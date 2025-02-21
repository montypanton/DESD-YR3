from django.contrib.auth.models import AbstractUser
from django.db import models

class CustomUser(AbstractUser):
    USER = 'User'
    ADMIN = 'Admin'
    AI_ENGINEER = 'AI Engineer'
    FINANCE = 'Finance'

    ROLE_CHOICES = [
        (USER, 'User'),
        (ADMIN, 'Admin'),
        (AI_ENGINEER, 'AI Engineer'),
        (FINANCE, 'Finance'),
    ]

    role = models.CharField(max_length=20, choices=ROLE_CHOICES, default=USER)
