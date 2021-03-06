from django.shortcuts import render_to_response, get_object_or_404
from django.http import HttpResponseRedirect, HttpResponse
from django.contrib import auth
from django.core.context_processors import csrf
from forms import *
from django.db.models.query import RawQuerySet
from dispense.models import *
from django.template import RequestContext
from django.utils import timezone
from django.core.mail import send_mail
import hashlib, datetime, random
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from obelix.settings import EMAIL_HOST_USER
from django.contrib.admin.views.decorators import staff_member_required
from obelix.supportFunctions import *
from operator import attrgetter


def home(request):
	return render_to_response('home.html', {'request': request} )

def login(request):
	d = {}
	d.update(csrf(request))
	
	if request.user.is_authenticated() :
		return HttpResponseRedirect('/cdl/all')
		
	return render_to_response('login.html', d)
							  
def auth_view(request):
	username_html = request.POST.get('username', '')
	password_html = request.POST.get('password', '')
	user = auth.authenticate(username=username_html, password=password_html)
    
	if user is not None:
		if user.is_active:
			auth.login(request, user)
			return HttpResponseRedirect('/accounts/loggedin')
		else:
			user_id = user.id
			return render_to_response('not_active.html', {'user_id': user_id, 
														  'request': request})
	else:
		return HttpResponseRedirect('/accounts/invalid')
		
def not_active(request):
	return render_to_response('not_active.html', {'request': request})
	
def invalid_login(request):
	return render_to_response('invalid_login.html', {'request': request})

@login_required
def logout(request):
	auth.logout(request)
	return render_to_response('home.html', {'request': request})
	
def register_user(request):
	args = {}
	args.update(csrf(request))
	if request.method == 'POST':
		form = RegistrationForm(request.POST)
		args['form'] = form
		if form.is_valid() :
			
			nome_html = form.cleaned_data['first_name']
			cognome_html = form.cleaned_data['last_name']
			email_html = form.cleaned_data['email']			
			username_html = form.cleaned_data['username']
			
			#form.save()
			
			
			ok = False
						
			for m in Studente.objects.raw('SELECT * FROM dispense_studente'):
				if (m.email) == email_html :
					if ((m.nome).upper() == nome_html.upper() and 
						(m.cognome).upper() == cognome_html.upper()) :
						form.save()
						ok = True
						break
			
			if ok == False :
				return HttpResponseRedirect('/accounts/register_failed')

				
			user = User.objects.get(username=username_html)			                                                                                                                              
			
			salt = hashlib.sha1(str(random.random())).hexdigest()[:5]            
			activation_key = hashlib.sha1(salt+email_html).hexdigest()            
			key_expires = timezone.now() + datetime.timedelta(2)
			
			new_profile = UserProfile(user=user, activation_key=activation_key, 
									  key_expires=key_expires)
			new_profile.save()

			email_subject = 'Attiva Account'
			email_body = "Hey %s, grazie per esserti registrato.\nPer attivare il tuo account, clicca sul link seguente entro 48 ore\nhttp://127.0.0.1:8000/accounts/attivazione/%s" % (username_html, activation_key)

			send_mail(email_subject, email_body, EMAIL_HOST_USER, [email_html], 
					  fail_silently=False)

			return HttpResponseRedirect('/accounts/register_success')
	else :
		args['form'] = RegistrationForm()
	
	args['request'] = request
	
	return render_to_response('register.html', args, 
							  context_instance=RequestContext(request))

def register_success(request):
    return render_to_response('register_success.html', {'request': request})
    
def register_failed(request):
    return render_to_response('register_failed.html', {'request': request})
    
    
def register_confirm(request, activation_key):
	user_profile = get_object_or_404(UserProfile, activation_key=activation_key)
		
	user = user_profile.user
	if user.is_active :
		return render_to_response('att_already_done.html', {'request': request})
		
	if user_profile.key_expires < timezone.now():
		return render_to_response('attivazione_scaduta.html', 
								  {'request': request})

	user.is_active = True
	user.save()
	return HttpResponseRedirect('/accounts/login', {'request': request})


def nuova_attivazione(request, user_id):
	user_profile = UserProfile.objects.get(user_id = user_id)
	
	#if request.user.is_authenticated():
	#se l'utente e' loggato e attivo (is.active == True) ritorna True alt. false
	
	#studente iscritto in precedenza, ora non piu' presente nel db universitario
	if user_profile.registrabile == False :
		return HttpResponseRedirect('/accounts/register_failed')
	
	if request.user.is_authenticated():		
		return render_to_response('att_already_done.html', {'request': request})
	
	else:
		utente = User.objects.get(id = user_id)
		user_profile.key_expires = timezone.now() + datetime.timedelta(2)		
		email_subject = 'Attiva Account'
		email_body = "Hey %s, grazie per esserti registrato.\nPer attivare il tuo account, clicca sul link seguente entro 48 ore\nhttp://127.0.0.1:8000/accounts/attivazione/%s" % (utente.username, user_profile.activation_key)
		send_mail(email_subject, email_body, EMAIL_HOST_USER, [utente.email], 
				  fail_silently=False)

		return render_to_response('nuova_attivazione.html',{'request': request}) 

@login_required
@unbanned_only
def cambio_username(request):
	args = {}
	args.update(csrf(request))
		
	if request.method == 'POST':
		form = ChangeUsernameForm(request.POST)
		args['form'] = form
		if form.is_valid():
			username_html = form.cleaned_data['username']
			utente = request.user
			utente.username = username_html
			utente.save()
			return HttpResponseRedirect('/accounts/profilo_utente')
				
	else :
		args['form'] = ChangeUsernameForm()

	args['request'] = request
	
	return render_to_response('cambio_username.html', args, 
							  context_instance=RequestContext(request))


@login_required
@unbanned_only
def profilo_utente(request):
	
	user_profile = UserProfile.objects.get(user_id = request.user.id)
	
	pubblicazioni = []  #dispense
	notifiche = []		#dispense
	ultimo_comm = []	#user
	
	for d in Dispensa.objects.all():
		if d.utente == user_profile.user:
			pubblicazioni.append(d)
	
	for d in Dispensa.objects.all(): # d e' una dispensa 
		for n in d.notifica.destinatari.all() : # n e' un user_profile 
			if n.user == user_profile.user : 
				notifiche.append(d) #lista di dispense
				if d.num_com > 0:
					c = Commentarium.objects.raw('SELECT * FROM \
					dispense_commentarium WHERE data_pub=(SELECT max(data_pub) \
					FROM dispense_commentarium \
					WHERE dispensa_id="'+str(d.id)+'")')[0]
					ultimo_comm.append(c)
					break
				
	return render_to_response('profilo_utente.html', 
							 {'pubblicazioni': pubblicazioni, 
							  'user_profile': user_profile,
							  'notifiche' : notifiche, 
							  'ultimo_comm': ultimo_comm, 
							  'request': request})	


@login_required
@unbanned_only
def volumica(request):
	return render_to_response('volumica.html', {'request': request})


@login_required
def not_globali(request):
	
	user_profile = UserProfile.objects.get(user_id = request.user.id)
	
	user_profile.not_globali = not user_profile.not_globali
	user_profile.save()
	
	return HttpResponseRedirect('/accounts/profilo_utente/')


@login_required
def not_locali_att(request, titolo_cdl, titolo_ins, dispensa_id):
	
	corso_ins = Corso.objects.get(titolo=titolo_cdl)
	materia = Insegnamento.objects.get(titolo=titolo_ins, corso=corso_ins)
	
	user_profile = UserProfile.objects.get(user_id = request.user.id)
	d = Dispensa.objects.get(id=dispensa_id)
	
	d.notifica.destinatari.add(user_profile)
	if d.notifica.controllo and user_profile.user == d.utente :
		d.notifica.controllo = False
		d.notifica.save()
		
	return HttpResponseRedirect("/cdl/%s/%s/recenti/" %(corso_ins.titolo, 
														materia.titolo))
	

def not_locali_dis(request,dispensa_id):

	user_profile = UserProfile.objects.get(user_id = request.user.id)
	d = Dispensa.objects.get(id=dispensa_id)
	d.notifica.destinatari.remove(user_profile)
	d.notifica.save()
	
	return HttpResponseRedirect('/accounts/profilo_utente/')


@login_required
@staff_member_required
def dispense_globali(request, ordine):
	
	disp = Dispensa.objects.all()

	
	if ordine == "insegnamento":
		disp = sorted(disp, key=attrgetter("insegnamento.titolo"))
	elif ordine == "autore" :
		disp = sorted(disp, key=attrgetter("utente.email"))	
	elif ordine == "pub":
		disp = sorted(disp, key=attrgetter("data_pub"))
	elif ordine == "pub_reverse":
		disp = sorted(disp, key=attrgetter("data_pub"))
		disp.reverse()
	
	return render_to_response('dispense_globali.html', {'Dispense': disp,
							  'request': request})


@login_required
@staff_member_required
def segnalazioni(request):
	seg = Segnalazione.objects.all()
	seg = sorted(seg, key=attrgetter("dispensa.id"))
	
	return render_to_response('segnalazioni.html', {'Segnalazioni': seg,
							  'request': request})


@login_required
@staff_member_required
def segn_annulla(request, segn_id):
	
	s = Segnalazione.objects.get(id=segn_id)
		
	s.dispensa.eliminabile = True
	s.dispensa.save()
	s.delete()
	
	return HttpResponseRedirect('/accounts/profilo_utente/superuser/segnalazioni/')


@login_required
@staff_member_required
def bannati(request, ordine):
	bannati = Bannato.objects.all()
	
	#for ban in Bannato.objects.all():
	#	bannati.append(ban)
	#bannati.sort()
				
	if ordine == "nome":
		bannati = sorted(bannati, key=attrgetter("user_profile.user.first_name"))
	elif ordine == "cognome":
		bannati = sorted(bannati, key=attrgetter("user_profile.user.last_name"))
	else:
		bannati = sorted(bannati, key=attrgetter("user_profile.user.email"))
	
				
	return render_to_response('bannati.html', {'Bannati': bannati,
							   'request': request})		
	

@login_required
@staff_member_required
def sban(request, user_profile_id):
	
	up = UserProfile.objects.get(id=user_profile_id)
	up.ban = False
	up.save()
			
	
	s = Bannato.objects.all().filter(user_profile = up)
	s.delete()
	
	return HttpResponseRedirect('/accounts/profilo_utente/superuser/bannati/nome/')
		

@login_required
@staff_member_required

def database(request, ordine):
	studente = Studente.objects.all()

	if ordine == "nome":
		studente = sorted(studente, key=attrgetter("nome"))
	elif ordine == "cognome":
		studente = sorted(studente, key=attrgetter("cognome"))
	else:
		studente = sorted(studente, key=attrgetter("email"))
	
	return render_to_response('database.html', 
							 {'Studente': studente, 'request': request})
	
	
@login_required
@staff_member_required

def iscritti(request, ordine):
	iscritti = UserProfile.objects.all()
	 
	if ordine == "nome":
		iscritti = sorted(iscritti, key=attrgetter("user.first_name"))
	elif ordine == "cognome":
		iscritti = sorted(iscritti, key=attrgetter("user.last_name"))
	else:
		iscritti = sorted(iscritti, key=attrgetter("user.email"))
	
	return render_to_response('iscritti.html', 
							 {'Iscritti': iscritti, 'request': request})
	
	
@login_required
@staff_member_required
def segn_ban (request, segn_id, us_id):
	args = {}
	args.update(csrf(request))
	
	if request.method == 'POST':
		form = BanForm(request.POST)
		args['form'] = form
		if form.is_valid() :
			
			if segn_id == "0": #ban che arriva da iscritti -> no segn.
				user_profile = UserProfile.objects.get(user_id = us_id)
			else:
				s = Segnalazione.objects.get(id=segn_id)
				if us_id == "":
					user_profile = UserProfile.objects.get(
												user_id = s.dispensa.utente.id)
				else:
					user_profile = UserProfile.objects.get(id = s.accusatore.id)
				s.delete()
	
			user_profile.ban = True
			user_profile.save()
	
			motivazione_html = form.cleaned_data['motivazione']		
			nuovo_bannato = Bannato.objects.create(user_profile = user_profile,
												motivazione=motivazione_html)
			nuovo_bannato.save()
				
			return HttpResponseRedirect('/accounts/profilo_utente/superuser/bannati/nome/')
	else :
		args['form'] = BanForm()
	
	args['request'] = request
	args['segn_id'] = segn_id
	args['us_id'] = us_id
	
	return render_to_response('aggiungi_ban.html', args, 
							  context_instance=RequestContext(request))		

	
@login_required
@staff_member_required
def inserisci(request):
	args = {}
	args.update(csrf(request))
	if request.method == 'POST':
		form = StudenteForm(request.POST)
		args['form'] = form
		if form.is_valid() :
			
			nome_html = form.cleaned_data['nome']
			cognome_html = form.cleaned_data['cognome']
			email_html = form.cleaned_data['email']			
			
		
			nuovo_studente = Studente.objects.create(nome=nome_html, 
													 cognome=cognome_html, 
													 email=email_html)
			nuovo_studente.save()
				
			return HttpResponseRedirect('/accounts/profilo_utente/superuser/database/')
	else :
		args['form'] = StudenteForm()
	
	args['request'] = request
	
	return render_to_response('aggiungi_stud.html', args, 
							  context_instance=RequestContext(request))
