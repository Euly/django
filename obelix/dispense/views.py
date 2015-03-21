from django.shortcuts import render_to_response
from dispense.models import Corso, Anno

# Create your views here.
# Creo la vista di dispense
def dispense(request):
	return render_to_response('dispense.html',
							  {'corsi': Corso.objects.all()})

def anno(request, titolo_cdl):
	cdl = Corso.objects.get(titolo = titolo_cdl)
	anni = []
	k = 0
	for i in Anno.objects.all():
		if i.corso == cdl :
			anni.append(i.num)
			
	return render_to_response('anno.html',
							  {'titolo': titolo_cdl, 'anni': anni})
							  
