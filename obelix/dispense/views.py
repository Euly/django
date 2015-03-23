from django.shortcuts import render_to_response
from dispense.models import Corso, Insegnamento

# Create your views here.
# Creo la vista di dispense
def dispense(request):
	return render_to_response('dispense.html',
							  {'corsi': Corso.objects.all()})

def insegnamento(request, titolo_cdl):
	cdl = Corso.objects.get(titolo = titolo_cdl)
	insegnamenti = []
	
	for i in Insegnamento.objects.all():
		if i.corso == cdl :
			insegnamenti.append(i.titolo)
			
	return render_to_response('insegnamenti.html',
							  {'titolo': titolo_cdl, 'insegnamenti': insegnamenti})
							  
def dettaglio_insegnamento(request, titolo_cdl, titolo_ins):
	corso_ins = Corso.objects.get(titolo=titolo_cdl)
	t = Insegnamento.objects.get(titolo=titolo_ins, corso=corso_ins)
	return render_to_response('dettaglio_insegnamento.html',
							  {'titolo_ins': titolo_ins})
