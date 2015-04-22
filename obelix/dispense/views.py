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
from django.core.servers.basehttp import FileWrapper
from django.contrib.auth.decorators import login_required
from django.contrib.auth.decorators import login_required

@login_required    
def cdl(request):
	return render_to_response('cdl.html',
							  {'corsi': Corso.objects.all()})

@login_required
def insegnamento(request, titolo_cdl):
	cdl = Corso.objects.get(titolo = titolo_cdl)
	insegnamenti = []
	
	for i in Insegnamento.objects.all():
		if i.corso == cdl :
			insegnamenti.append(i.titolo)
			
	return render_to_response('insegnamenti.html',
							  {'titolo': titolo_cdl, 'insegnamenti': insegnamenti})

@login_required						  
def dettaglio_insegnamento(request, titolo_cdl, titolo_ins):
	corso_ins = Corso.objects.get(titolo=titolo_cdl)
	materia = Insegnamento.objects.get(titolo=titolo_ins, corso=corso_ins)
	dispense = []
	
	for d in Dispensa.objects.all():
		if d.insegnamento == materia:
			dispense.append(d)
	
	return render_to_response('dettaglio_insegnamento.html',
							  {'titolo_ins': titolo_ins, 'titolo_cdl': titolo_cdl, 'dispense': dispense, 'request': request})

@login_required						  
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
										documento=documento_html,
										utente=request.user.username)
			
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

@login_required
def cancella_dispensa(request, titolo_cdl, titolo_ins, dispensa_id):
	corso_ins = Corso.objects.get(titolo=titolo_cdl)
	materia = Insegnamento.objects.get(titolo=titolo_ins, corso=corso_ins)
	
	d = Dispensa.objects.get(id=dispensa_id)
	d.delete()
			
	return HttpResponseRedirect('/cdl/%s/%s' %(corso_ins.titolo, materia.titolo))
		


@login_required
def scarica(request, titolo_cdl, titolo_ins, titolo_file):
	
	corso_ins = Corso.objects.get(titolo=titolo_cdl)
	materia = Insegnamento.objects.get(titolo=titolo_ins, corso=corso_ins)
	
	dispense = []
	
	for d in Dispensa.objects.all():
		if d.insegnamento == materia:
			dispense.append(d)
	
	
	for f in dispense:
		path_file = []
		path_file = f.documento.path.split('/')
		nome_file = path_file[len(path_file) -1 ]
	
		if nome_file == titolo_file:
			wrapper = FileWrapper(f.documento)
			response = HttpResponse(wrapper)	
			return response

	return HttpResponseRedirect("/cdl/all")

@login_required
def like_dispensa(request, titolo_cdl, titolo_ins, dispensa_id):
	corso_ins = Corso.objects.get(titolo=titolo_cdl)
	materia = Insegnamento.objects.get(titolo=titolo_ins, corso=corso_ins)
	
	if dispensa_id:
		d = Dispensa.objects.get(id=dispensa_id)
		d.mi_piace = d.mi_piace + 1
		d.save()
		
	return HttpResponseRedirect("/cdl/%s/%s" %(corso_ins.titolo, materia.titolo))
	
@login_required
def unlike_dispensa(request, titolo_cdl, titolo_ins, dispensa_id):
	corso_ins = Corso.objects.get(titolo=titolo_cdl)
	materia = Insegnamento.objects.get(titolo=titolo_ins, corso=corso_ins)
	
	if dispensa_id:
		d = Dispensa.objects.get(id=dispensa_id)
		d.non_mi_piace = d.non_mi_piace + 1
		d.save()
		
	return HttpResponseRedirect("/cdl/%s/%s" %(corso_ins.titolo, materia.titolo))
	












