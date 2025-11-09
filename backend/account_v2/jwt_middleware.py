import jwt
import logging
from django.conf import settings
from django.contrib.auth import login as django_login
from django.http import HttpRequest
from django.utils.deprecation import MiddlewareMixin

from account_v2.models import User
from account_v2.user import UserService
from account_v2.organization import OrganizationService
from tenant_account_v2.models import OrganizationMember
from tenant_account_v2.organization_member_service import OrganizationMemberService
from utils.user_session import UserSessionUtils

logger = logging.getLogger(__name__)

class JWTAuthenticationMiddleware(MiddlewareMixin):
    """Middleware to handle JWT-based authentication from main application"""
    
    def process_request(self, request: HttpRequest):
        # Skip authentication for certain paths
        skip_paths = ['/api/v1/health/', '/admin/', '/static/', '/media/']
        if any(request.path.startswith(path) for path in skip_paths):
            return None
            
        # Skip if user is already authenticated
        if hasattr(request, 'user') and request.user.is_authenticated:
            return None
            
        # Check for JWT token in Authorization header
        auth_header = request.META.get('HTTP_AUTHORIZATION', '')
        if not auth_header.startswith('Bearer '):
            return None
            
        token = auth_header.split(' ')[1]
        
        try:
            # Decode JWT token
            payload = jwt.decode(
                token, 
                settings.SHARED_JWT_SECRET, 
                algorithms=['HS256']
            )
            
            # Extract user info
            user_id = payload.get('user_id')
            email = payload.get('email')
            organization_id = payload.get('organization_id')
            
            if not all([user_id, email, organization_id]):
                return None
                
            # Get user
            user_service = UserService()
            user = user_service.get_user_by_email(email=email)
            
            if not user or not user.is_active:
                return None
                
            # Get organization
            organization = OrganizationService.get_organization_by_org_id(organization_id)
            if not organization:
                return None
                
            # Get or create organization member
            try:
                org_member = OrganizationMemberService.get_user_by_id(id=user.id)
                if not org_member:
                    org_member = OrganizationMember(
                        user=user,
                        role='admin',
                        is_login_onboarding_msg=False,
                        is_prompt_studio_onboarding_msg=False,
                    )
                    org_member.save()
            except Exception as e:
                logger.error(f"Error getting/creating organization member: {e}")
                return None
                
            # Set user in request
            request.user = user
            
            # Set session data
            UserSessionUtils.set_organization_id(request, organization_id)
            UserSessionUtils.set_organization_member_role(request, org_member)
            
        except jwt.ExpiredSignatureError:
            logger.debug("JWT token expired")
            return None
        except jwt.InvalidTokenError:
            logger.debug("Invalid JWT token")
            return None
        except Exception as e:
            logger.error(f"JWT authentication error: {e}")
            return None
            
        return None