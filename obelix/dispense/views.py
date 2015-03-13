from django.shortcuts import render_to_response
from dispense.models import Corso

# Create your views here.
# Creo la vista di dispense

def dispense(request):
	return render_to_response('dispense.html',
							  {'dispense': Corso.objects.all()})

def corso(request, dispense_titolo="LT-Fisica"):
	return render_to_response('corso.html',
							  {'corso': Corso.objects.get(titolo=dispense_titolo)})
