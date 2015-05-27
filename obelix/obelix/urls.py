
from django.conf.urls import patterns, include, url
from django.core.urlresolvers import reverse
from django.views.generic import RedirectView
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
	# home del sito visualizzabile da tutti
	url(r'^$', RedirectView.as_view(url='home/')),
	url(r'^home/$', 'obelix.views.home'),
	
	# url relativi ai corsi di laurea con le relative dispense, vedi in 
	# "dispense/urls.py"
	url(r'^cdl/', include('dispense.urls')),
	
	# url relativo all'interfaccia di amministrazione django
	url(r'^admin/', include(admin.site.urls)),
	
	# url relativi all'autenticazione e registrazione degli utenti
	url(r'^accounts/login/$',  'obelix.views.login'),
	url(r'^accounts/auth/$',  'obelix.views.auth_view'),
	url(r'^accounts/not_active/$', 'obelix.views.not_active'),    
	url(r'^accounts/logout/$', 'obelix.views.logout'),
	url(r'^accounts/loggedin/$',RedirectView.as_view(url='/home/')),
	url(r'^accounts/invalid/$', 'obelix.views.invalid_login'),    
	url(r'^accounts/register/$', 'obelix.views.register_user'),
	url(r'^accounts/register_success/$', 'obelix.views.register_success'),
	url(r'^accounts/register_failed/$', 'obelix.views.register_failed'),	
	url(r'^accounts/attivazione/(?P<activation_key>\w+)/$', 'obelix.views.register_confirm'),	
	url(r'^accounts/resetta_password/$', 'django.contrib.auth.views.password_reset',
	{'post_reset_redirect' : '/accounts/password/modificata/'}, name="password_reset"),
	url(r'^accounts/password/modificata/$', 'django.contrib.auth.views.password_reset_done'),
	url(r'^accounts/password/resetta_password/(?P<uidb36>[0-9A-Za-z]+)-(?P<token>.+)/$', 'django.contrib.auth.views.password_reset_confirm', 
	{'post_reset_redirect' : '/accounts/password/modificata/'}),
	url(r'^accounts/password/modificata/$','django.contrib.auth.views.password_reset_complete'),
	url(r'^accounts/nuova_attivazione/(?P<user_id>\d+)/$', 'obelix.views.nuova_attivazione'),
	
	# url relativi al profilo utente degli user
	url(r'^accounts/profilo_utente/cambio_username/$', 'obelix.views.cambio_username'),
	url(r'^accounts/profilo_utente/$', 'obelix.views.profilo_utente'),
	url(r'^accounts/profilo_utente/notifiche_globali/$', 'obelix.views.not_globali'),
	url(r'^accounts/profilo_utente/notifiche_locali/(?P<titolo_cdl>\w+-\w+)/(?P<titolo_ins>[\w+|\s*|\']*)/(?P<dispensa_id>\d+)/$', 'obelix.views.not_locali_att'),	
	url(r'^accounts/profilo_utente/notifiche_locali/(?P<dispensa_id>\d+)/dis/', 'obelix.views.not_locali_dis'),
	
	# url riservati all'amministratore del sistema per la gestione delle 
	# segnalazioni degli utenti
	url(r'^accounts/profilo_utente/superuser/dispense/(?P<ordine>|insegnamento|autore|pub|pub_reverse)/$', 'obelix.views.dispense_globali'),	   
	url(r'^accounts/profilo_utente/superuser/segnalazioni/$', 'obelix.views.segnalazioni'),
	url(r'^accounts/profilo_utente/superuser/segnalazioni/annulla/(?P<segn_id>\d+)/$', 'obelix.views.segn_annulla'),
	url(r'^accounts/profilo_utente/superuser/segnalazioni/ban/(?P<segn_id>\d+)/(?P<us_id>[\d+|]*)$', 'obelix.views.segn_ban'),
	url(r'^accounts/profilo_utente/superuser/database/(?P<ordine>|nome|cognome|email)/$', 'obelix.views.database'),
	url(r'^accounts/profilo_utente/superuser/database/inserisci/$', 'obelix.views.inserisci'),
	url(r'^accounts/profilo_utente/superuser/iscritti/(?P<ordine>|nome|cognome|email)/$', 'obelix.views.iscritti'),
	url(r'^accounts/profilo_utente/superuser/bannati/(?P<ordine>|nome|cognome|email)/$', 'obelix.views.bannati'),
	url(r'^accounts/profilo_utente/superuser/sban/(?P<user_profile_id>\d+)/$', 'obelix.views.sban'),
	
	# url relativo alla nuova iniziativa dei rappresentanti degli studenti che 
	# prende il nome di "volumica"; accessibile a tutti
	url(r'^volumica/$', 'obelix.views.volumica'),  
	)
