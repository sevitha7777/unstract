import jwt
import logging
from django.conf import settings
from django.contrib.auth import login as django_login
from django.shortcuts import redirect
from django.http import HttpRequest, JsonResponse
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework import status

from account_v2.models import User, Organization
from account_v2.user import UserService
from account_v2.organization import OrganizationService
from tenant_account_v2.models import OrganizationMember
from tenant_account_v2.organization_member_service import OrganizationMemberService
from utils.user_session import UserSessionUtils

logger = logging.getLogger(__name__)

@api_view(['GET'])
@permission_classes([AllowAny])
def sso_login(request: HttpRequest):
    """SSO login endpoint that accepts JWT token from main application"""
    try:
        token = request.GET.get('token')
        if not token:
            return redirect('/login?error=missing_token')
        
        # Decode JWT token
        try:
            payload = jwt.decode(
                token, 
                settings.SHARED_JWT_SECRET, 
                algorithms=['HS256']
            )
        except jwt.ExpiredSignatureError:
            return redirect('/login?error=token_expired')
        except jwt.InvalidTokenError:
            return redirect('/login?error=invalid_token')
        
        # Extract user info from token
        user_id = payload.get('user_id')
        email = payload.get('email')
        username = payload.get('username')
        organization_id = payload.get('organization_id')
        
        if not all([user_id, email, username, organization_id]):
            return redirect('/login?error=invalid_payload')
        
        # Get or create user
        user_service = UserService()
        user = user_service.get_user_by_email(email=email)
        
        if not user:
            return redirect('/login?error=user_not_found')
        
        # Get organization
        organization = OrganizationService.get_organization_by_org_id(organization_id)
        if not organization:
            return redirect('/login?error=organization_not_found')
        
        # Create organization member if doesn't exist
        try:
            org_member = OrganizationMemberService.get_user_by_id(id=user.id)
            if not org_member:
                org_member = OrganizationMember(
                    user=user,
                    role='admin',  # Default role
                    is_login_onboarding_msg=False,
                    is_prompt_studio_onboarding_msg=False,
                )
                org_member.save()
        except Exception as e:
            logger.error(f"Error creating organization member: {e}")
        
        # Login user
        django_login(request, user)
        
        # Set session data
        UserSessionUtils.set_organization_id(request, organization_id)
        UserSessionUtils.set_organization_member_role(request, org_member)
        
        # Redirect to main application
        return redirect('/')
        
    except Exception as e:
        logger.error(f"SSO login error: {e}")
        return redirect('/login?error=sso_failed')

@api_view(['POST'])
@permission_classes([AllowAny])
def validate_sso_token(request: HttpRequest):
    """API endpoint to validate SSO token without login"""
    try:
        token = request.data.get('token')
        if not token:
            return Response({'valid': False, 'error': 'missing_token'}, 
                          status=status.HTTP_400_BAD_REQUEST)
        
        try:
            payload = jwt.decode(
                token, 
                settings.SHARED_JWT_SECRET, 
                algorithms=['HS256']
            )
            return Response({'valid': True, 'payload': payload})
        except jwt.ExpiredSignatureError:
            return Response({'valid': False, 'error': 'token_expired'}, 
                          status=status.HTTP_401_UNAUTHORIZED)
        except jwt.InvalidTokenError:
            return Response({'valid': False, 'error': 'invalid_token'}, 
                          status=status.HTTP_401_UNAUTHORIZED)
            
    except Exception as e:
        logger.error(f"Token validation error: {e}")
        return Response({'valid': False, 'error': 'validation_failed'}, 
                      status=status.HTTP_500_INTERNAL_SERVER_ERROR)