"""URL configuration for backend project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/

Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""

import os
from account_v2.admin import admin
from django.conf import settings
from django.conf.urls import *  # noqa: F401, F403
from django.conf.urls.static import static
from django.urls import include, path
from backend.adapter_instance_view import adapter_instance_view

urlpatterns = [
    path("adapter_instance", adapter_instance_view, name="adapter_instance"),
    path("", include("account_v2.urls")),
    # Connector OAuth
    path("", include("connector_auth_v2.urls")),
    # Docs
    path("", include("docs.urls")),
    # Pipeline
    path("pipeline/", include("pipeline_v2.public_api_urls")),
    # health checks
    path("", include("health.urls")),
]

# Conditionally include feature flags only if flipt service is available
if os.getenv("FLIPT_SERVICE_AVAILABLE", "false").lower() == "true":
    urlpatterns.append(path("flags/", include("feature_flag.urls")))
if settings.ADMIN_ENABLED:
    # Admin URLs
    urlpatterns += [
        path("admin/", admin.site.urls),
        path(
            "admin/doc/",
            include("django.contrib.admindocs.urls"),
        ),
    ]
urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
