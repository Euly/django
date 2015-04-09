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

def login(request):
	d = {}
	d.update(csrf(request))    
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
			return HttpResponseRedirect('/accounts/not_active')
	else:
		return HttpResponseRedirect('/accounts/invalid')
		
def loggedin(request):
	return render_to_response('loggedin.html', {'full_name': request.user.username})

def not_active(request):
	return render_to_response('not_active.html')
	
def invalid_login(request):
	return render_to_response('invalid_login.html')

def logout(request):
	auth.logout(request)
	return render_to_response('logout.html')
	
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
			
			ok = False
			
			for m in Studente.objects.raw('SELECT * FROM dispense_studente'):
				if m.email == email_html :
					if m.nome == nome_html and m.cognome == cognome_html :
						form.save()
						ok = True
						break
			
			if ok == False :
				return HttpResponseRedirect('/accounts/register_failed')

			username_html = form.cleaned_data['username']		
			salt = hashlib.sha1(str(random.random())).hexdigest()[:5]            
			activation_key = hashlib.sha1(salt+email_html).hexdigest()            
			key_expires = timezone.now() + datetime.timedelta(2)
			#key_expires = datetime.datetime.today() + datetime.timedelta(2)

			user = User.objects.get(username=username_html)			                                                                                                                              
			new_profile = UserProfile(user=user, activation_key=activation_key, key_expires=key_expires)
			new_profile.save()

			email_subject = 'Attiva Account'
			email_body = "Hey %s, grazie per esserti registrato.\nPer attivare il tuo account, clicca sul link seguente entro 48 ore\nhttp://127.0.0.1:8000/accounts/attivazione/%s" % (username_html, activation_key)

			send_mail(email_subject, email_body, 'obelixfim@gmail.com', [email_html], fail_silently=False)

			return HttpResponseRedirect('/accounts/register_success')
		else :
			return HttpResponseRedirect('/accounts/register_failed')
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
	return render_to_response('attivazione.html')


