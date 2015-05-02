#scripts/estendo_superuser.py
from django.contrib.auth.models import User
from dispense.models import UserProfile
from django.utils import timezone

u=UserProfile(user=User.objects.get(is_superuser=1),activation_key = "SU", key_expires=timezone.now())
u.save()
  
