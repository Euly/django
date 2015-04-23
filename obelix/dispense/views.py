from django.shortcuts import render_to_response
from dispense.models import Corso, Insegnamento, Dispensa, Opinione, Commentarium
from forms import DispensaForm, CommentariumForm
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
										utente=request.user.id)
			
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
		
		try:
		# controllo se ho gia' cliccato uno dei due bottoni
			opinione = Opinione.objects.get(dispensa=d, utente=request.user)
			
			# non posso mettere piu' di un like
			if opinione.positiva == True:
				return HttpResponseRedirect("/cdl/%s/%s" %(corso_ins.titolo, materia.titolo))
			
			# se ho cambiato idea tolgo il non mi piace
			if opinione.negativa == True:
				opinione.negativa = False
				opinione.positiva = True
				opinione.save()
				d.non_mi_piace = d.non_mi_piace - 1
				
				
		
		except:
			# se invece non ho ancora cliccato nessun bottone devo 
			# creare un nuovo oggetto di tipo Opinione
			opinione = Opinione.objects.create(utente=request.user,
											   dispensa=d,
											   positiva=True)
		
		d.mi_piace = d.mi_piace + 1
		d.save()
		
	return HttpResponseRedirect("/cdl/%s/%s" %(corso_ins.titolo, materia.titolo))
	
@login_required
def unlike_dispensa(request, titolo_cdl, titolo_ins, dispensa_id):
	corso_ins = Corso.objects.get(titolo=titolo_cdl)
	materia = Insegnamento.objects.get(titolo=titolo_ins, corso=corso_ins)
	
	if dispensa_id:
		d = Dispensa.objects.get(id=dispensa_id)
		
		try:
		# controllo se ho gia' cliccato uno dei due bottoni
			opinione = Opinione.objects.get(dispensa=d, utente=request.user)
			
			# non posso mettere piu' di un unlike
			if opinione.negativa == True:
				return HttpResponseRedirect("/cdl/%s/%s" %(corso_ins.titolo, materia.titolo))
			
			# se ho cambiato idea tolgo il mi piace
			if opinione.positiva == True:
				opinione.positiva = False
				opinione.negativa = True
				opinione.save()
				d.mi_piace = d.mi_piace - 1
				
				
		except:
			opinione = Opinione.objects.create(utente=request.user,
											   dispensa=d,
											   negativa=True)		
		d.non_mi_piace = d.non_mi_piace + 1
		d.save()
		
	return HttpResponseRedirect("/cdl/%s/%s" %(corso_ins.titolo, materia.titolo))
	

@login_required
def adiungo(request, titolo_cdl, titolo_ins, dispensa_id):
	corso_ins = Corso.objects.get(titolo=titolo_cdl)
	materia = Insegnamento.objects.get(titolo=titolo_ins, corso=corso_ins)
	
	args = {}
	args.update(csrf(request))
	
	if request.method == 'POST':
		form = CommentariumForm(request.POST)
		args['form'] = form

		if form.is_valid():			
			scriptum_html = form.cleaned_data['scriptum']
			d = Dispensa.objects.get(id=dispensa_id)
			s = Commentarium.objects.create(homo=request.user.id,  volumen=d, scriptum=scriptum_html)
			
			##					data_pub=timezone.now()
			
			return HttpResponseRedirect('/cdl/%s/%s' %(corso_ins.titolo, materia.titolo))
	else:
		args['form']= CommentariumForm()
		
	
	args['titolo_cdl'] = titolo_cdl
	args['titolo_ins'] = titolo_ins
	args['dispensa_id'] = dispensa_id
	
	return render_to_response('addo.html', args, context_instance=RequestContext(request))










