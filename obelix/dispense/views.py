from django.shortcuts import render_to_response
from dispense.models import Corso, Insegnamento, Dispensa
from forms import DispensaForm
from django.http import HttpResponseRedirect
from django.core.context_processors import csrf
from django.http import HttpResponse
from django.template import RequestContext
from django.contrib import messages
from django.conf import settings
from django.utils import timezone

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
	materia = Insegnamento.objects.get(titolo=titolo_ins, corso=corso_ins)
	dispense = []
	
	for d in Dispensa.objects.all():
		if d.insegnamento == materia:
			dispense.append(d)
	
	return render_to_response('dettaglio_insegnamento.html',
							  {'titolo_ins': titolo_ins, 'titolo_cdl': titolo_cdl, 'dispense': dispense})
							  
def aggiungi_dispensa(request, titolo_cdl, titolo_ins):
	corso_ins = Corso.objects.get(titolo=titolo_cdl)
	materia = Insegnamento.objects.get(titolo=titolo_ins, corso=corso_ins)
	
	
	
	if request.POST:
		form = DispensaForm(request.POST, request.FILES)
		if form.is_valid():
			titolo_html = form.cleaned_data['titolo']
			descrizione_html = form.cleaned_data['descrizione']
			documento_html = form.cleaned_data['documento']
			
			d = Dispensa.objects.create(titolo=titolo_html, 
										descrizione=descrizione_html, 
										data_pub=timezone.now(),
										insegnamento=materia,
										documento=documento_html)
			
			messages.add_message(request, messages.SUCCESS, "Aggiunta riuscita")
			return HttpResponseRedirect('/cdl/%s/%s' %(corso_ins.titolo, materia.titolo))
			
	else:
		form = DispensaForm()
		
	args = {}
	args.update(csrf(request))
	
	args['form'] = form
	args['titolo_cdl'] = titolo_cdl
	args['titolo_ins'] = titolo_ins
	
	return render_to_response('aggiungi_dispensa.html', args)
