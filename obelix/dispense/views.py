from django.shortcuts import render_to_response
from dispense.models import Corso, Insegnamento
from forms import DispensaForm
from django.http import HttpResponseRedirect
from django.core.context_processors import csrf

# Create your views here.
# Creo la vista di dispense
def cdl(request):
	return render_to_response('cdl.html',
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
							  {'titolo_ins': titolo_ins, 'titolo_cdl': titolo_cdl})
							  
def aggiungi_dispensa(request, titolo_cdl, titolo_ins):
	corso_ins = Corso.objects.get(titolo=titolo_cdl)
	t = Insegnamento.objects.get(titolo=titolo_ins, corso=corso_ins)
	
	if request.POST:
		form = DispensaForm(request.POST)
		if form.is_valid():
			form.save()
			
		return HttpResponseRedirect('/cdl/all')
	else:
		form = DispensaForm()
		
	args = {}
	args.update(csrf(request))
	
	args['form'] = form
	
	return render_to_response('aggiungi_dispensa.html', args)
