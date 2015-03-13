from django.shortcuts import render_to_response
from dispense.models import Corso, Anno

# Create your views here.
# Creo la vista di dispense

def dispense(request):
	return render_to_response('dispense.html',
							  {'dispense': Corso.objects.all()})

def anno(request):
	return render_to_response('anno.html',
							  {'anno': Corso.objects.all()})
