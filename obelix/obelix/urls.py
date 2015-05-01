
from django.conf.urls import patterns, include, url
from django.core.urlresolvers import reverse
from django.views.generic import RedirectView
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
	url(r'^$', RedirectView.as_view(url='home/')),
	url(r'^home/$', 'obelix.views.home'),
	url(r'^cdl/', include('dispense.urls')),
	url(r'^admin/', include(admin.site.urls)),   
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
	url(r'^accounts/profilo_utente/cambio_username/$', 'obelix.views.cambio_username'),
	url(r'^accounts/profilo_utente/$', 'obelix.views.profilo_utente'),
	url(r'^accounts/profilo_utente/notifiche_globali/$', 'obelix.views.not_globali'),
	url(r'^accounts/profilo_utente/notifiche_locali/(?P<dispensa_id>\d+)/(?P<flag>att|dis)/$', 'obelix.views.not_locali'),	
	url(r'^volumica/$', 'obelix.views.volumica'),  
	)
