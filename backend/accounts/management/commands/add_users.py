from django.core.management.base import BaseCommand
from accounts.models import CustomUser
from django.contrib.auth.hashers import make_password

class Command(BaseCommand):
    help = 'Add users with hashed passwords'

    def handle(self, *args, **kwargs):
        users = [
            {'username': 'enduser1', 'email': 'enduser1@example.com', 'password': 'password123', 'first_name': 'End', 'last_name': 'User', 'user_type': 'END_USER', 'organization': 'ExampleOrg'},
            {'username': 'aiengineer1', 'email': 'aiengineer1@example.com', 'password': 'password123', 'first_name': 'AI', 'last_name': 'Engineer', 'user_type': 'AI_ENGINEER', 'organization': 'ExampleOrg'},
            {'username': 'admin1', 'email': 'admin1@example.com', 'password': 'password123', 'first_name': 'Admin', 'last_name': 'User', 'user_type': 'ADMIN', 'organization': 'ExampleOrg'},
            {'username': 'finance1', 'email': 'finance1@example.com', 'password': 'password123', 'first_name': 'Finance', 'last_name': 'User', 'user_type': 'FINANCE', 'organization': 'ExampleOrg'},
        ]

        for user_data in users:
            user_data['password'] = make_password(user_data['password'])
            user = CustomUser(**user_data)
            user.save()
            self.stdout.write(self.style.SUCCESS(f"User {user.username} created successfully"))
