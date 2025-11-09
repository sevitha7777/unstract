from urllib.parse import quote_plus

from django.conf import settings


class CeleryConfig:
    """Specifies celery configuration

    Refer https://docs.celeryq.dev/en/stable/userguide/configuration.html
    """

    # Result backend configuration
    result_backend = (
        f"db+postgresql://{settings.DB_USER}:{quote_plus(settings.DB_PASSWORD)}"
        f"@{settings.DB_HOST}:{settings.DB_PORT}/{settings.CELERY_BACKEND_DB_NAME}"
    )

    # Broker URL configuration
    broker_url = settings.CELERY_BROKER_URL

    # Task serialization and content settings
    accept_content = ["json"]
    task_serializer = "json"
    result_serializer = "json"
    result_extended = True

    # Timezone and logger settings
    timezone = "UTC"
    worker_hijack_root_logger = False

    beat_scheduler = "django_celery_beat.schedulers:DatabaseScheduler"

    task_acks_late = True
    
    # Connection retry and stability settings
    broker_connection_retry_on_startup = True
    broker_connection_retry = True
    broker_connection_max_retries = 10
    broker_heartbeat = 60
    
    # Worker settings for connection loss handling
    worker_cancel_long_running_tasks_on_connection_loss = True
    task_reject_on_worker_lost = True
    
    # Prefetch and concurrency settings
    worker_prefetch_multiplier = 1
    task_always_eager = False
    
    # Connection pool settings
    broker_pool_limit = 10
    broker_connection_timeout = 30
    broker_connection_retry_delay = 5
