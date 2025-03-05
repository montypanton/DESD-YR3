from django.urls import path
from .views import home, end_user_view, ai_engineer_view, admin_view, finance_view

urlpatterns = [
    path('', home, name='home'),
    path('end_user/', end_user_view, name='end_user'),
    path('ai_engineer/', ai_engineer_view, name='ai_engineer'),
    path('admin/', admin_view, name='admin'),
    path('finance/', finance_view, name='finance'),
]
