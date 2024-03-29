"""lwandisurf URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
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
from django.conf import settings
from django.conf.urls import url
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path, include

from rest_framework import routers
from rest_framework.authtoken.views import obtain_auth_token

from core.api.viewsets import LwandisurfViewSet
from gallery.api.viewsets import AlbumViewSet, PhotoViewSet
from rest_framework_swagger.views import get_swagger_view
from user.api.viewsets import UserViewSet
from blog.api.viewsets import PostViewSet

router = routers.SimpleRouter()
router.register(r'lwandisurf', LwandisurfViewSet)
router.register(r'albums', AlbumViewSet)
router.register(r'photos', PhotoViewSet)
router.register(r'users', UserViewSet)
router.register(r'posts', PostViewSet)

urlpatterns = [
                  path('admin/', admin.site.urls),
                  path('api-auth/', obtain_auth_token),
                  path('', include(router.urls)),
                  path('summernote/', include('django_summernote.urls')),
                  # url(r'^$', get_swagger_view(title='API Reference', urlconf='lwandisurf.urls'), name='api_docs'),
                  url(r'^$', get_swagger_view(title='Endpoints'), name='api_docs'),

              ] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
