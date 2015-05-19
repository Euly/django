#scripts/estendo_superuser.py
from django.contrib.auth.models import User
from dispense.models import UserProfile
from django.utils import timezone

try:
	superuser = User.objects.get(is_superuser=1)
except:
	superuser = User.objects.create_superuser(username="obelix", password="dbdjob@@", email="obelix.fim@gmail.com")


u=UserProfile(user=superuser,activation_key = "SU", key_expires=timezone.now())
u.save()
  
