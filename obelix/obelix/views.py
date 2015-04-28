from django.shortcuts import render_to_response, get_object_or_404
from django.http import HttpResponseRedirect, HttpResponse
from django.contrib import auth
from django.core.context_processors import csrf
from forms import RegistrationForm
from django.db.models.query import RawQuerySet
from dispense.models import Studente
from dispense.models import UserProfile	
from django.template import RequestContext
from django.utils import timezone
from forms import *
from django.core.mail import send_mail
import hashlib, datetime, random
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from obelix.settings import EMAIL_HOST_USER
from dispense.models import Dispensa, Notifica


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
			return render_to_response('not_active.html', {'user_id': user_id})
	else:
		return HttpResponseRedirect('/accounts/invalid')
		
def loggedin(request):
	return render_to_response('loggedin.html', {'full_name': request.user.username})

def not_active(request):
	return render_to_response('not_active.html')
	
def invalid_login(request):
	return render_to_response('invalid_login.html')

@login_required
def logout(request):
	auth.logout(request)
	return render_to_response('home.html')
	
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
			
			form.save()
			
			
			#ok = False
						
			#for m in Studente.objects.raw('SELECT * FROM dispense_studente'):
			#	if (m.email) == email_html :
			#		if (m.nome).upper() == nome_html.upper() and (m.cognome).upper() == cognome_html.upper() :
			#			form.save()
			#			ok = True
			#			break
			#if ok == False :
			#	return HttpResponseRedirect('/accounts/register_failed')

				
			user = User.objects.get(username=username_html)			                                                                                                                              
			
			salt = hashlib.sha1(str(random.random())).hexdigest()[:5]            
			activation_key = hashlib.sha1(salt+email_html).hexdigest()            
			key_expires = timezone.now() + datetime.timedelta(2)
			
			new_profile = UserProfile(user=user, activation_key=activation_key, key_expires=key_expires)
			new_profile.save()

			email_subject = 'Attiva Account'
			email_body = "Hey %s, grazie per esserti registrato.\nPer attivare il tuo account, clicca sul link seguente entro 48 ore\nhttp://127.0.0.1:8000/accounts/attivazione/%s" % (username_html, activation_key)

			send_mail(email_subject, email_body, EMAIL_HOST_USER, [email_html], fail_silently=False)

			return HttpResponseRedirect('/accounts/register_success')
	else :
		args['form'] = RegistrationForm()

	return render_to_response('register.html', args, context_instance=RequestContext(request))

def register_success(request):
    return render_to_response('register_success.html')
    
def register_failed(request):
    return render_to_response('register_failed.html')
    
    
def register_confirm(request, activation_key):
	user_profile = get_object_or_404(UserProfile, activation_key=activation_key)
		
	if user_profile.key_expires < timezone.now():
		return render_to_response('attivazione_scaduta.html')
		
	user = user_profile.user
	if user.is_active :
		return render_to_response('att_already_done.html')

	user.is_active = True
	user.save()
	return HttpResponseRedirect('/accounts/login')



def nuova_attivazione(request, user_id):
	
	user_profile = UserProfile.objects.get(user_id = user_id)
	
	#if request.user.is_authenticated():
	#se l'utente e' loggato e attivo (is.active == True) ritorna True alt. false
	
	if request.user.is_authenticated():		
		return render_to_response('att_already_done.html')
	
	else:
		utente = User.objects.get(id = user_id)
		user_profile.key_expires = timezone.now() + datetime.timedelta(2)		
		email_subject = 'Attiva Account'
		email_body = "Hey %s, grazie per esserti registrato.\nPer attivare il tuo account, clicca sul link seguente entro 48 ore\nhttp://127.0.0.1:8000/accounts/attivazione/%s" % (utente.username, user_profile.activation_key)
		send_mail(email_subject, email_body, EMAIL_HOST_USER, [utente.email], fail_silently=False)

		return render_to_response('nuova_attivazione.html') 

@login_required
def cambio_username(request):
	args = {}
	args.update(csrf(request))
		
	if request.method == 'POST':
		form = ChangeUsernameForm(request.POST)
		args['form'] = form
		if form.is_valid():
			username_html = form.cleaned_data['new_username']
			User.objects.get(username=username_html)
			utente = request.user
			utente.username = username_html
			utente.save()
			return HttpResponseRedirect('/accounts/loggedin')
				
	else :
		args['form'] = ChangeUsernameForm()

	return render_to_response('cambio_username.html', args, context_instance=RequestContext(request))
		
@login_required
def profilo_utente(request):
	
	#io voglio tutte le dispense corrispondenti a quell' utente
	#da modificare modello dispense
	
	user_profile = UserProfile.objects.get(user_id = request.user.id)
	
	pubblicazioni = []
	notifiche = []
	
	
	for d in Dispensa.objects.all():
		if d.utente == user_profile.user:
			pubblicazioni.append(d)
	
	for d in Dispensa.objects.all(): # d e' una dispensa 
		for n in d.notifica.destinatari.all() : # n e' un user_profile 
			if n.user == user_profile.user: 
				notifiche.append(d) #lista di dispense
									#esci ciclo inferiore
				
	return render_to_response('profilo_utente.html', {'pubblicazioni': pubblicazioni, 'user_profile': user_profile,
							 'notifiche' : notifiche, 'request': request})

@login_required
def volumica(request):
	return render_to_response('volumica.html')
	
@login_required
def not_globali(request):
	
	user_profile = UserProfile.objects.get(user_id = request.user.id)
	
	user_profile.not_globali = not user_profile.not_globali
	user_profile.save()
	
	return HttpResponseRedirect('/accounts/profilo_utente/')

@login_required
def not_locali(request, dispensa_id):
	
	user_profile = UserProfile.objects.get(user_id = request.user.id)
	d = Dispensa.objects.get(id=dispensa_id)
	
	#rimuovere user da d.notifica.destinatari
	d.notifica.destinatari.remove(user_profile)
	1
	return HttpResponseRedirect('/accounts/profilo_utente/')
	
	
	
	
