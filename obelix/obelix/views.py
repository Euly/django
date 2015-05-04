from django.shortcuts import render_to_response, get_object_or_404
from django.shortcuts import render_to_response, get_object_or_404
from django.http import HttpResponseRedirect, HttpResponse
from django.contrib import auth
from django.core.context_processors import csrf
from forms import RegistrationForm, StudenteForm
from django.db.models.query import RawQuerySet
from dispense.models import Studente, UserProfile, Dispensa, Notifica, Commentarium, Segnalazione, Bannato
from django.template import RequestContext
from django.utils import timezone
from forms import *
from django.core.mail import send_mail
import hashlib, datetime, random
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from obelix.settings import EMAIL_HOST_USER
from django.contrib.admin.views.decorators import staff_member_required
from obelix.supportFunctions import unbanned_only


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
			return render_to_response('not_active.html', {'user_id': user_id, 'request': request})
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
					if (m.nome).upper() == nome_html.upper() and (m.cognome).upper() == cognome_html.upper() :
						form.save()
						ok = True
						break
			
			if ok == False :
				return HttpResponseRedirect('/accounts/register_failed')

				
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
	
	args['request'] = request
	
	return render_to_response('register.html', args, context_instance=RequestContext(request))

def register_success(request):
    return render_to_response('register_success.html', {'request': request})
    
def register_failed(request):
    return render_to_response('register_failed.html', {'request': request})
    
    
def register_confirm(request, activation_key):
	user_profile = get_object_or_404(UserProfile, activation_key=activation_key)
		
	if user_profile.key_expires < timezone.now():
		return render_to_response('attivazione_scaduta.html', {'request': request})
		
	user = user_profile.user
	if user.is_active :
		return render_to_response('att_already_done.html', {'request': request})

	user.is_active = True
	user.save()
	return HttpResponseRedirect('/accounts/login', {'request': request})



def nuova_attivazione(request, user_id):
	
	user_profile = UserProfile.objects.get(user_id = user_id)
	
	#if request.user.is_authenticated():
	#se l'utente e' loggato e attivo (is.active == True) ritorna True alt. false
	
	if request.user.is_authenticated():		
		return render_to_response('att_already_done.html', {'request': request})
	
	else:
		utente = User.objects.get(id = user_id)
		user_profile.key_expires = timezone.now() + datetime.timedelta(2)		
		email_subject = 'Attiva Account'
		email_body = "Hey %s, grazie per esserti registrato.\nPer attivare il tuo account, clicca sul link seguente entro 48 ore\nhttp://127.0.0.1:8000/accounts/attivazione/%s" % (utente.username, user_profile.activation_key)
		send_mail(email_subject, email_body, EMAIL_HOST_USER, [utente.email], fail_silently=False)

		return render_to_response('nuova_attivazione.html', {'request': request}) 


@login_required
@unbanned_only
def cambio_username(request):
	args = {}
	args.update(csrf(request))
		
	if request.method == 'POST':
		form = ChangeUsernameForm(request.POST)
		args['form'] = form
		if form.is_valid():
			username_html = form.cleaned_data['new_username']
			utente = request.user
			utente.username = username_html
			utente.save()
			return HttpResponseRedirect('/accounts/profilo_utente')
				
	else :
		args['form'] = ChangeUsernameForm()

	args['request'] = request
	
	return render_to_response('cambio_username.html', args, context_instance=RequestContext(request))

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
				if Commentarium.objects.all() is  None:
					c = Commentarium.objects.raw('SELECT * FROM dispense_commentarium WHERE data_pub=(SELECT max(data_pub) FROM dispense_commentarium where dispensa_id="'+str(d.id)+'")')[0]
					ultimo_comm.append(c)
				break			
		
	return render_to_response('profilo_utente.html', {'pubblicazioni': pubblicazioni, 'user_profile': user_profile,
							  'notifiche' : notifiche, 'ultimo_comm': ultimo_comm, 'request': request})	
	

@login_required
@unbanned_only
def volumica(request):
	return render_to_response('volumica.html',{'request': request})


	
@login_required
def not_globali(request):
	
	user_profile = UserProfile.objects.get(user_id = request.user.id)
	
	user_profile.not_globali = not user_profile.not_globali
	user_profile.save()
	
	return HttpResponseRedirect('/accounts/profilo_utente/')

@login_required
def not_locali(request, dispensa_id, flag):
	
	user_profile = UserProfile.objects.get(user_id = request.user.id)
	d = Dispensa.objects.get(id=dispensa_id)
	
	if flag == "att" :
		d.notifica.destinatari.add(user_profile)
		if d.notifica.controllo and user_profile.user == d.utente :
			d.notifica.controllo = False
			d.notifica.save()
			
	if flag == "dis":
		d.notifica.destinatari.remove(user_profile)
		
	return HttpResponseRedirect('/accounts/profilo_utente/')


@login_required
@staff_member_required
def dispense_globali(request):
	
	return render_to_response('dispense_globali.html', {'Dispense': Dispensa.objects.all(),
							   'request': request})

@login_required
@staff_member_required
def segnalazioni(request):

	return render_to_response('segnalazioni.html', {'Segnalazioni': Segnalazione.objects.all(),
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
def bannati(request):
				
	bannati = Bannato.objects.all()
	
	#for ban in Bannato.objects.all():
	#	bannati.append(ban)
	
	#bannati.sort()
				
	return render_to_response('bannati.html', {'Bannati': bannati,
							   'request': request})		
	
@login_required
@staff_member_required
def sban(request, user_profile_id):
	
	up = UserProfile.objects.get(id=user_profile_id)
	up.ban = False
	up.save()
			
	#ordinare bannati		
	
	#tenere in memoria i ban passati?		
	s = Bannato.objects.all().filter(user_profile = up)
	s.delete()
	
	return HttpResponseRedirect('/accounts/profilo_utente/superuser/bannati/')
		

@login_required
@staff_member_required

def database(request):
	
	studente = []
	studente = Studente.objects.all()
	
	return render_to_response('database.html', {'Studente': studente, 'request': request})
	
	
	
@login_required
@staff_member_required

def iscritti(request):
	
	iscritti = []
	iscritti = UserProfile.objects.all()
	
	return render_to_response('iscritti.html', {'Iscritti': iscritti, 'request': request})
	
	
@login_required
@staff_member_required
def segn_ban (request, segn_id):
		
	args = {}
	args.update(csrf(request))
	
	if request.method == 'POST':
		form = BanForm(request.POST)
		args['form'] = form
		if form.is_valid() :
	
			s = Segnalazione.objects.get(id=segn_id)
			user_profile = UserProfile.objects.get(user_id = s.dispensa.utente.id)
	
			user_profile.ban = True
			user_profile.save()
			s.delete()
	
	
			motivazione_html = form.cleaned_data['motivazione']		
			nuovo_bannato = Bannato.objects.create(user_profile = user_profile,
												motivazione=motivazione_html)
			nuovo_bannato.save()
				
			return HttpResponseRedirect('/accounts/profilo_utente/superuser/bannati/')
	else :
		args['form'] = BanForm()
	
	args['request'] = request
	args['segn_id'] = segn_id
	
	return render_to_response('aggiungi_ban.html', args, context_instance=RequestContext(request))		

	
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
			
		
			nuovo_studente = Studente.objects.create(nome=nome_html, cognome=cognome_html, email=email_html)
			nuovo_studente.save()
			#form.save()
				
			return HttpResponseRedirect('/accounts/profilo_utente/superuser/database/')
	else :
		args['form'] = StudenteForm()
	
	args['request'] = request
	
	return render_to_response('aggiungi_stud.html', args, context_instance=RequestContext(request))
	
	
	
	
	

