# base_urls.py
from django.conf import settings
from django.urls import include, path

from .public_urls_v2 import urlpatterns as public_urls
from .adapter_instance_view import adapter_instance_view

# Import urlpatterns from each file
from .urls_v2 import urlpatterns as tenant_urls

# SDK adapter instance endpoint - must be first to bypass auth middleware
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
from django.db import connection

@csrf_exempt
def adapter_instance_no_auth(request):
    """Adapter instance endpoint without authentication for SDK."""
    adapter_instance_id = request.GET.get('adapter_instance_id')
    if not adapter_instance_id:
        return JsonResponse({'error': 'adapter_instance_id is required'}, status=400)
    
    try:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT adapter_id, adapter_name, adapter_type, adapter_metadata_b 
                FROM adapter_instance 
                WHERE id = %s
            """, [adapter_instance_id])
            row = cursor.fetchone()
            
        if not row:
            return JsonResponse({'error': 'Adapter not found'}, status=404)
            
        metadata = row[3].tobytes().decode('utf-8') if row[3] else '{}'
        return JsonResponse({
            'adapter_id': row[0],
            'adapter_name': row[1], 
            'adapter_type': row[2],
            'adapter_metadata': metadata,
        })
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

urlpatterns = [
    path("adapter_instance", adapter_instance_no_auth, name="adapter_instance_root"),
];

# Combine the URL patterns
urlpatterns += [
    path(
        f"{settings.TENANT_SUBFOLDER_PREFIX}/",
        include((tenant_urls, "tenant"), namespace="tenant"),
    ),
    path(
        f"{settings.PATH_PREFIX}/", include((public_urls, "public"), namespace="public")
    ),
    # API deployment
    path(f"{settings.API_DEPLOYMENT_PATH_PREFIX}/", include("api_v2.execution_urls")),
    path(
        f"{settings.API_DEPLOYMENT_PATH_PREFIX}/pipeline/",
        include("pipeline_v2.public_api_urls"),
    ),
    path("", include("health.urls")),
    # Internal API for worker communication
    path("internal/", include("backend.internal_base_urls")),
]
