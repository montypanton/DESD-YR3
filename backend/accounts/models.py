from django.contrib.auth.models import AbstractUser, Group, Permission
from django.db import models
from django.db.models.signals import post_save
from django.dispatch import receiver

class CustomUser(AbstractUser):
    USER_TYPE_CHOICES = (
        ('END_USER', 'End User'),
        ('AI_ENGINEER', 'AI Engineer'),
        ('ADMIN', 'Admin'),
        ('FINANCE', 'Finance'),
    )
    user_type = models.CharField(max_length=20, choices=USER_TYPE_CHOICES)
    organization = models.CharField(max_length=100, blank=True, null=True)

@receiver(post_save, sender=CustomUser)
def create_user_groups(sender, instance, created, **kwargs):
    if created:
        if instance.is_superuser:
            admin_group, created = Group.objects.get_or_create(name='Admin')
            instance.groups.add(admin_group)
        else:
            user_group, created = Group.objects.get_or_create(name='User')
            instance.groups.add(user_group)
