#!/usr/bin/env python3
"""
Simple Django backend for testing confidence scoring locally
"""
import os
import sys
import django
from django.conf import settings
from django.core.management import execute_from_command_line
from django.http import JsonResponse
from django.urls import path
from django.views.decorators.csrf import csrf_exempt
import json

# Configure Django settings
if not settings.configured:
    settings.configure(
        DEBUG=True,
        SECRET_KEY='test-key-for-local-development',
        DATABASES={
            'default': {
                'ENGINE': 'django.db.backends.postgresql',
                'NAME': 'unstract_db',
                'USER': 'unstract_dev',
                'PASSWORD': '',
                'HOST': 'localhost',
                'PORT': '5432',
            }
        },
        INSTALLED_APPS=[
            'django.contrib.contenttypes',
            'django.contrib.auth',
            'corsheaders',
        ],
        MIDDLEWARE=[
            'corsheaders.middleware.CorsMiddleware',
            'django.middleware.common.CommonMiddleware',
        ],
        CORS_ALLOW_ALL_ORIGINS=True,
        ROOT_URLCONF=__name__,
        ALLOWED_HOSTS=['*'],
    )

django.setup()

# Import confidence calculator
sys.path.append('/Users/sevithakannali/unstract/backend')
from utils.confidence_calculator import ConfidenceCalculator

@csrf_exempt
def test_confidence(request):
    """Test endpoint for confidence scoring"""
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            output = data.get('output', '')
            prompt_type = data.get('prompt_type', 'text')
            context = data.get('context', '')
            
            calculator = ConfidenceCalculator()
            result = calculator.calculate_confidence(
                output=output,
                prompt_type=prompt_type,
                context=context
            )
            
            return JsonResponse({
                'success': True,
                'confidence_data': result
            })
        except Exception as e:
            return JsonResponse({
                'success': False,
                'error': str(e)
            })
    
    return JsonResponse({'message': 'Confidence scoring test endpoint'})

@csrf_exempt
def login(request):
    """Simple login endpoint"""
    if request.method == 'POST':
        return JsonResponse({
            'success': True,
            'user': {'username': 'unstract'},
            'token': 'test-token'
        })
    return JsonResponse({'message': 'Login endpoint'})

@csrf_exempt
def session(request):
    """Session endpoint"""
    return JsonResponse({
        'success': True,
        'user': {'username': 'unstract'},
        'authenticated': True
    })

@csrf_exempt
def socket_endpoint(request):
    """Socket endpoint placeholder"""
    return JsonResponse({'message': 'Socket not implemented in simple backend'})

# URL patterns
urlpatterns = [
    path('api/v1/test-confidence/', test_confidence, name='test_confidence'),
    path('api/v1/login/', login, name='login'),
    path('api/v1/session/', session, name='session'),
    path('api/v1/socket/', socket_endpoint, name='socket'),
]

if __name__ == '__main__':
    if len(sys.argv) > 1 and sys.argv[1] == 'runserver':
        from django.core.management.commands.runserver import Command
        cmd = Command()
        cmd.run_from_argv(['manage.py', 'runserver', 'localhost:8000'])
    else:
        print("🚀 Simple Backend for Confidence Scoring")
        print("📱 Test endpoint: http://localhost:8000/api/v1/test-confidence/")
        print("🔑 Login endpoint: http://localhost:8000/api/v1/login/")
        print("")
        print("Run with: python simple-backend.py runserver")