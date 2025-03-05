from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required, user_passes_test

@login_required
def home(request):
    return render(request, 'home/index.html')

@login_required
def end_user_view(request):
    return render(request, 'home/end_user.html')

@login_required
def ai_engineer_view(request):
    return render(request, 'home/ai_engineer.html')

@login_required
def admin_view(request):
    return render(request, 'home/admin.html')

@login_required
def finance_view(request):
    return render(request, 'home/finance.html')
