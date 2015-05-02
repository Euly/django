from django.shortcuts import render_to_response
from dispense.models import Corso, UserProfile, Insegnamento, Dispensa, Opinione, Commentarium, Notifica, Segnalazione
from forms import DispensaForm, CommentariumForm, SegnalazioneForm
from obelix.supportFunctions import *
from django.http import HttpResponseRedirect
from django.core.context_processors import csrf
from django.http import HttpResponse
from django.template import RequestContext
from django.contrib import messages
from django.conf import settings
from django.utils import timezone
from django.core.servers.basehttp import FileWrapper
from django.contrib.auth.decorators import login_required
import subprocess
import os.path
Temp_Path = os.path.realpath('.')

@login_required    
def cdl(request):
	return render_to_response('cdl.html',
							  {'corsi': Corso.objects.all(),
							   'request': request})

@login_required
def insegnamento(request, titolo_cdl):
	cdl = Corso.objects.get(titolo = titolo_cdl)
	insegnamenti = []
	
	for i in Insegnamento.objects.all():
		if i.corso == cdl :
			insegnamenti.append(i.titolo)
			
	return render_to_response('insegnamenti.html',
							  {'titolo': titolo_cdl, 
							   'insegnamenti': insegnamenti,
							   'request': request})

@login_required						  
def dettaglio_insegnamento(request, titolo_cdl, titolo_ins, ordine):
	corso_ins = Corso.objects.get(titolo=titolo_cdl)
	materia = Insegnamento.objects.get(titolo=titolo_ins, corso=corso_ins)
	
	dispense = []
	commenti = []
	
	for d in Dispensa.objects.all():
		if d.insegnamento == materia:
			dispense.append(d)
			for c in Commentarium.objects.all():
				if c.dispensa == d:
					commenti.append(c)
	
	if ordine is not None:
		if ordine == "cron_reverse":
			dispense.reverse()
		elif ordine == "likes":
			bubble_sort(dispense)
			
	user_profile = UserProfile.objects.get(user_id = request.user.id)
	
	return render_to_response('dettaglio_insegnamento.html',
							 {'titolo_ins': titolo_ins, 
							  'titolo_cdl': titolo_cdl,
							  'dispense': dispense, 
							  'commenti': commenti, 
							  'up' : user_profile,
							  'request': request})

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
			
			n = Notifica.objects.create()
			
			d = Dispensa.objects.create(insegnamento = materia,
										utente = request.user,
										titolo=titolo_html, 
										descrizione=descrizione_html, 
										data_pub=timezone.now(),
										documento=documento_html,
										notifica=n)
	
			
			return HttpResponseRedirect("/cdl/%s/%s" %(corso_ins.titolo, materia.titolo))
			
	else:
		form = DispensaForm()
		
	args = {}
	args.update(csrf(request))
	
	args['form'] = form
	args['titolo_cdl'] = titolo_cdl
	args['titolo_ins'] = titolo_ins
	args['request'] = request
	
	return render_to_response('aggiungi_dispensa.html', args)

@login_required
def cancella_dispensa(request, titolo_cdl, titolo_ins, dispensa_id):
	corso_ins = Corso.objects.get(titolo=titolo_cdl)
	materia = Insegnamento.objects.get(titolo=titolo_ins, corso=corso_ins)
	
	d = Dispensa.objects.get(id=dispensa_id)
	subprocess.check_output("rm "+Temp_Path+"/static/"+str(d.documento), shell=True)
	
	#se non cancello la notifica rimane nel database
	d.notifica.delete()
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
def like_dispensa(request, titolo_cdl, titolo_ins, flag, dispensa_id):
	corso_ins = Corso.objects.get(titolo=titolo_cdl)
	materia = Insegnamento.objects.get(titolo=titolo_ins, corso=corso_ins)
	
	if dispensa_id:
		d = Dispensa.objects.get(id=dispensa_id)
		
		try:
		# controllo se ho gia' cliccato uno dei due bottoni
			opinione = Opinione.objects.get(dispensa=d, utente=request.user)
			
			# non posso mettere piu' di un like o unlike
			#if (flag == "like" and opinione.positiva == True) or (flag == "unlike" and opinione.negativa == True):
			#	return HttpResponseRedirect("/cdl/%s/%s" %(corso_ins.titolo, materia.titolo))
			
			# se ho cambiato idea tolgo l'opinione precendente
			if flag == "like" and opinione.negativa == True:
				opinione.negativa = False
				opinione.positiva = True
				opinione.save()
				d.non_mi_piace = d.non_mi_piace - 1
				
			elif flag == "unlike" and opinione.positiva == True:
				opinione.positiva = False
				opinione.negativa = True
				opinione.save()
				d.mi_piace = d.mi_piace - 1
				
		except:
			# se invece non ho ancora cliccato nessun bottone devo 
			# creare un nuovo oggetto di tipo Opinione
			if flag == "like":
				opinione = Opinione.objects.create(utente=request.user,
												   dispensa=d,
												   positiva=True)
			elif flag == "unlike":
				opinione = Opinione.objects.create(utente=request.user,
												   dispensa=d,
												   negativa=True)
		
		# dopo tutti i controlli posso finalmente aggiungere il like o
		# l'unlike alla dispensa selezionata
		if flag == "like":
			d.mi_piace = d.mi_piace + 1
			
		elif flag == "unlike":
			d.non_mi_piace = d.non_mi_piace + 1
		
		
		d.save()
		
	return HttpResponseRedirect("/cdl/%s/%s" %(corso_ins.titolo, materia.titolo))


@login_required
def aggiungi_commento(request, titolo_cdl, titolo_ins, dispensa_id):
	corso_ins = Corso.objects.get(titolo=titolo_cdl)
	materia = Insegnamento.objects.get(titolo=titolo_ins, corso=corso_ins)
	
	args = {}
	args.update(csrf(request))
	
	if request.method == 'POST':
		form = CommentariumForm(request.POST)
		args['form'] = form

		if form.is_valid():			
			commento_html = form.cleaned_data['commento']
			d = Dispensa.objects.get(id=dispensa_id)
			c = Commentarium.objects.create(utente=request.user,  dispensa=d, commento=commento_html)
								
			user_profile = UserProfile.objects.get(user_id = request.user.id)
									
			#ogni utente che commenta viene aggiunto alle notifiche
			if user_profile.not_globali :
				d.notifica.destinatari.add(user_profile)			
				
				
			#il creatore viene aggiunto alle notifiche solo all'inserimento del  1 commento
			if d.notifica.controllo == True :
				user_profile = UserProfile.objects.get(user_id = d.utente.id)
				if user_profile.not_globali:
					d.notifica.controllo = False
					d.notifica.destinatari.add(user_profile)
					d.notifica.save()
			
			return HttpResponseRedirect('/cdl/%s/%s' %(corso_ins.titolo, materia.titolo))
	else:
		args['form']= CommentariumForm()
		
	
	args['titolo_cdl'] = titolo_cdl
	args['titolo_ins'] = titolo_ins
	args['dispensa_id'] = dispensa_id
	args['request'] = request
	
	return render_to_response('commento.html', args, context_instance=RequestContext(request))


@login_required
def rimuovi_commento(request, titolo_cdl, titolo_ins, commento_id):
	
	corso_ins = Corso.objects.get(titolo=titolo_cdl)
	materia = Insegnamento.objects.get(titolo=titolo_ins, corso=corso_ins)
	
	c = Commentarium.objects.get(id=commento_id)
	c.delete()
			
	return HttpResponseRedirect('/cdl/%s/%s' %(corso_ins.titolo, materia.titolo))
	


@login_required
def segnalazione(request, titolo_cdl, titolo_ins, dispensa_id):
	
	corso_ins = Corso.objects.get(titolo=titolo_cdl)
	materia = Insegnamento.objects.get(titolo=titolo_ins, corso=corso_ins)
	
	args = {}
	args.update(csrf(request))
	
	if request.method == 'POST':
		form = SegnalazioneForm(request.POST)
		args['form'] = form

		if form.is_valid():			
			motivazione_html = form.cleaned_data['motivazione']
			d = Dispensa.objects.get(id=dispensa_id)
			d.eliminabile = False
			
			user_profile = UserProfile.objects.get(user_id = request.user.id)
			
			s = Segnalazione.objects.create(accusatore=user_profile,
											dispensa=d, motivazione=motivazione_html)
														
			return HttpResponseRedirect('/cdl/%s/%s' %(corso_ins.titolo, materia.titolo))
	else:
		args['form']= SegnalazioneForm()
		
	args['titolo_cdl'] = titolo_cdl
	args['titolo_ins'] = titolo_ins
	args['dispensa_id'] = dispensa_id
	#args['commento_id'] = commento_id
	args['request'] = request
	
	return render_to_response('segnalazione.html', args, context_instance=RequestContext(request))
	

