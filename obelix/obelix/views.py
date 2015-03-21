from django.shortcuts import render_to_response
from django.http import HttpResponseRedirect
from django.contrib import auth
from django.core.context_processors import csrf
from forms import Registrazione
from django.db.models.query import RawQuerySet
from dispense.models import Studente


def login(request):
    d = {}
    d.update(csrf(request))    
    return render_to_response('login.html', d)
							  
def auth_view(request):
    username = request.POST.get('username', '')
    password = request.POST.get('password', '')
    user = auth.authenticate(username=username, password=password)
    
    if user is not None:
        auth.login(request, user)
        return HttpResponseRedirect('/accounts/loggedin')
    else:
        return HttpResponseRedirect('/accounts/invalid')
    
def loggedin(request):
    return render_to_response('loggedin.html', 
                              {'full_name': request.user.username})

def invalid_login(request):
    return render_to_response('invalid_login.html')

def logout(request):
    auth.logout(request)
    return render_to_response('logout.html')

def register_user(request):
    if request.method == 'POST':
        form = Registrazione(request.POST)
        
        if form.is_valid():
			nome_html = form.cleaned_data['first_name']
			cognome_html = form.cleaned_data['last_name']
			matricola_html = form.cleaned_data['matricola']
			
			for m in Studente.objects.raw('SELECT * FROM dispense_studente'):
				if m.matricola == matricola_html :
					if m.nome == nome_html and m.cognome == cognome_html :
						form.save()
						return HttpResponseRedirect('/accounts/register_success')
					else :
						break
			
			return HttpResponseRedirect('/accounts/register_failed')
        
    args = {}
    args.update(csrf(request))
    
    args['form'] = Registrazione()
    
    return render_to_response('register.html', args)

def register_success(request):
    return render_to_response('register_success.html')
    
def register_failed(request):
    return render_to_response('register_failed.html')

