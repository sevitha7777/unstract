import logging
import uuid
from typing import Any

from django.contrib.auth import authenticate, login
from django.db import IntegrityError, transaction
from django.utils.text import slugify
from rest_framework import status
from rest_framework.request import Request
from rest_framework.response import Response

from account_v2.authentication_helper import AuthenticationHelper
from account_v2.authentication_service import AuthenticationService
from account_v2.constants import DefaultOrg
from account_v2.dto import MemberData, OrganizationData
from account_v2.enums import UserRole
from account_v2.models import Organization, User
from account_v2.organization import OrganizationService
from account_v2.serializer import UserSignupSerializer
from tenant_account_v2.models import OrganizationMember
from tenant_account_v2.organization_member_service import (
    OrganizationMemberService,
)
from utils.user_context import UserContext
from utils.user_session import UserSessionUtils

logger = logging.getLogger(__name__)


class EmailPasswordAuthService(AuthenticationService):
    """Authentication service that supports email/password login and signup."""

    def __init__(self) -> None:
        super().__init__()
        self.authentication_helper = AuthenticationHelper()
        self.default_organization = None

    # ------------------------------------------------------------------
    # Public API
    # ------------------------------------------------------------------
    def user_login(self, request: Request) -> Any:
        if request.method == "GET":
            # Allow the default template flow for backwards compatibility
            return super().user_login(request)

        payload = self._extract_payload(request)
        username = payload.get("username") or payload.get("email")
        password = payload.get("password")

        if not username or not password:
            return Response(
                {"message": "Username and password are required"},
                status=status.HTTP_400_BAD_REQUEST,
            )

        username = username.strip().lower()

        # Preserve existing mock login behaviour if those credentials are supplied
        if (
            username == DefaultOrg.MOCK_USER
            and password == DefaultOrg.MOCK_USER_PASSWORD
        ):
            return super().user_login(request)

        django_request = self._django_request(request)
        user = authenticate(django_request, username=username, password=password)
        if not user or user.is_superuser:
            return Response(
                {"message": "Invalid username or password"},
                status=status.HTTP_401_UNAUTHORIZED,
            )

        login(django_request, user)
        self._set_user_context(django_request, user)
        return Response({"message": "success"}, status=status.HTTP_200_OK)

    def user_signup(self, request: Request) -> Any:
        if request.method != "POST":
            return Response(status=status.HTTP_405_METHOD_NOT_ALLOWED)

        serializer = UserSignupSerializer(data=self._extract_payload(request))
        serializer.is_valid(raise_exception=True)

        email = serializer.validated_data["email"].lower()
        password = serializer.validated_data["password"]
        full_name = serializer.validated_data.get("full_name", "")
        organization_name = serializer.validated_data.get("organization_name") or self._default_org_name_from_email(
            email
        )
        requested_org_id = serializer.validated_data.get("organization_id")

        try:
            with transaction.atomic():
                if User.objects.filter(email=email).exists():
                    return Response(
                        {"message": "Email already registered"},
                        status=status.HTTP_400_BAD_REQUEST,
                    )

                user = self._create_user(email=email, password=password, full_name=full_name)
                organization = self._create_organization(
                    requested_org_id=requested_org_id,
                    organization_name=organization_name,
                    user=user,
                )
                member = OrganizationMember.objects.create(
                    user=user,
                    organization=organization,
                    role=UserRole.ADMIN.value,
                )
                self.authentication_helper.create_initial_platform_key(
                    user=user,
                    organization=organization,
                )
        except IntegrityError as exc:
            logger.error("Sign-up failed due to integrity error: %s", exc)
            return Response(
                {"message": "Failed to create organization. Try a different name."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        # Authenticate and login the freshly created user
        django_request = self._django_request(request)
        user = authenticate(django_request, username=email, password=password)
        if user:
            login(django_request, user)
            self._set_user_context(django_request, user, member=member)

        response = {
            "message": "success",
            "organization": {
                "id": organization.organization_id,
                "name": organization.display_name,
            },
        }
        return Response(response, status=status.HTTP_201_CREATED)

    def user_logout(self, request: Request) -> Response:
        return Response({"message": "success"}, status=status.HTTP_200_OK)

    def user_organizations(self, request: Request) -> list[OrganizationData]:
        if not request.user.is_authenticated:
            return []
        return self._organizations_for_user(request.user)

    def get_organizations_by_user_id(self, user_id: str) -> list[OrganizationData]:
        members = OrganizationMember.objects.filter(user__user_id=user_id)
        return [
            OrganizationData(
                id=member.organization.organization_id,
                display_name=member.organization.display_name,
                name=member.organization.name,
            )
            for member in members
            if member.organization
        ]

    def get_organization_by_org_id(self, id: str) -> OrganizationData:
        organization = OrganizationService.get_organization_by_org_id(org_id=id)
        if not organization:
            raise ValueError("Organization not found")
        return OrganizationData(
            id=organization.organization_id,
            display_name=organization.display_name,
            name=organization.name,
        )

    def add_to_organization(
        self,
        request: Request,
        user: User,
        data: dict[str, Any] | None = None,
    ) -> MemberData:
        if not data:
            raise ValueError("Organization data required")

        organization_id = data.get("organization_id")
        if not organization_id:
            raise ValueError("organization_id is required")

        organization = OrganizationService.get_organization_by_org_id(
            org_id=organization_id
        )
        if not organization:
            raise ValueError("Organization not found")

        role = data.get("role") or UserRole.USER.value
        member, _ = OrganizationMember.objects.get_or_create(
            organization=organization,
            user=user,
            defaults={"role": role},
        )
        member.role = role
        member.save()

        return MemberData(
            user_id=user.user_id,
            email=user.email,
            name=user.get_full_name(),
            organization_id=organization.organization_id,
            role=[role],
        )

    def make_organization_and_add_member(
        self,
        user_id: str,
        user_name: str,
        organization_name: str | None = None,
        display_name: str | None = None,
    ) -> OrganizationData | None:
        organization_name = organization_name or self.make_user_organization_display_name(
            user_name
        )
        org_id = self._ensure_unique_org_id(
            slugify(organization_name) or f"org-{uuid.uuid4().hex[:8]}"
        )
        return OrganizationData(
            id=org_id,
            display_name=display_name or organization_name,
            name=organization_name,
        )

    # ------------------------------------------------------------------
    # Internal helpers
    # ------------------------------------------------------------------
    def _create_user(self, email: str, password: str, full_name: str) -> User:
        user = User.objects.create_user(username=email, email=email, password=password)
        user.user_id = str(uuid.uuid4())
        if full_name:
            parts = full_name.strip().split(" ", 1)
            user.first_name = parts[0]
            if len(parts) > 1:
                user.last_name = parts[1]
        user.save()
        return user

    def _create_organization(
        self,
        requested_org_id: str | None,
        organization_name: str,
        user: User,
    ) -> Organization:
        base_identifier = (
            slugify(requested_org_id or organization_name) or f"org-{uuid.uuid4().hex[:8]}"
        )
        organization_id = self._ensure_unique_org_id(base_identifier)
        organization = OrganizationService.create_organization(
            name=organization_name,
            display_name=organization_name,
            organization_id=organization_id,
        )
        organization.created_by = user
        organization.modified_by = user
        organization.save()
        return organization

    def _ensure_unique_org_id(self, base_identifier: str) -> str:
        candidate = base_identifier
        suffix = 1
        while OrganizationService.get_organization_by_org_id(candidate):
            candidate = f"{base_identifier}-{suffix}"
            suffix += 1
        return candidate

    def _default_org_name_from_email(self, email: str) -> str:
        local_part = email.split("@")[0]
        return local_part or f"organization-{uuid.uuid4().hex[:6]}"

    def _extract_payload(self, request: Request) -> dict[str, Any]:
        if hasattr(request, "data") and request.data:
            return dict(request.data)
        if request.POST:
            return request.POST.dict()
        return {}

    def _organizations_for_user(self, user: User) -> list[OrganizationData]:
        members = (
            OrganizationMember._base_manager.select_related("organization")
            .filter(user=user)
        )
        organizations: list[OrganizationData] = []
        for member in members:
            organization = member.organization
            if organization:
                organizations.append(
                    OrganizationData(
                        id=organization.organization_id,
                        display_name=organization.display_name,
                        name=organization.name,
                    )
                )
        return organizations

    def _set_user_context(
        self,
        request: Any,
        user: User,
        member: OrganizationMember | None = None,
    ) -> None:
        membership = member
        if membership is None:
            membership = (
                OrganizationMember._base_manager.select_related("organization")
                .filter(user__user_id=user.user_id)
                .first()
            )
        if not membership or not membership.organization:
            return

        organization = membership.organization
        UserContext.set_organization_identifier(organization.organization_id)
        UserSessionUtils.set_organization_id(request, organization.organization_id)
        UserSessionUtils.set_organization_member_role(request, membership)
        request.session["user_id"] = user.user_id
        OrganizationMemberService.set_user_membership_in_organization_cache(
            user_id=user.user_id,
            organization_id=organization.organization_id,
        )

    def _django_request(self, request: Request | Any) -> Any:
        """Return the underlying Django HttpRequest for authentication APIs."""
        return getattr(request, "_request", request)
