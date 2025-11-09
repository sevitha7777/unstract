from .auth_service import EmailPasswordAuthService

metadata = {
    "name": "email_password_auth",
    "service_class": EmailPasswordAuthService,
    "description": "Email/password authentication with organization signup",
    "is_active": True,
}
