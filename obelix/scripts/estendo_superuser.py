#scripts/estendo_superuser.py
from django.contrib.auth.models import User
from dispense.models import UserProfile

u=UserProfile(user=User.objects.get(is_superuser=1),activation_key = "SU")
u.save()
  
