from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods
from django.db import connection


@csrf_exempt
@require_http_methods(["GET"])
def adapter_instance_view(request):
    """Simple adapter instance endpoint for SDK compatibility."""
    adapter_instance_id = request.GET.get('adapter_instance_id')
    
    if not adapter_instance_id:
        return JsonResponse({'error': 'adapter_instance_id is required'}, status=400)
    
    try:
        with connection.cursor() as cursor:
            cursor.execute(
                "SELECT adapter_id, adapter_name, adapter_type, adapter_metadata FROM unstract.adapter_instance WHERE id = %s",
                [adapter_instance_id]
            )
            row = cursor.fetchone()
            
        if not row:
            return JsonResponse({'error': 'Adapter not found'}, status=404)
            
        return JsonResponse({
            'adapter_id': row[0],
            'adapter_name': row[1],
            'adapter_type': row[2],
            'adapter_metadata': row[3],  # This should be the unencrypted JSON
        })
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)