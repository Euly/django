
from django.conf.urls import patterns, include, url
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
	url(r'^cdl/', include('dispense.urls')),
	url(r'^admin/', include(admin.site.urls)),   
	url(r'^accounts/login/$',  'obelix.views.login'),
	url(r'^accounts/auth/$',  'obelix.views.auth_view'),
	url(r'^accounts/not_active/$', 'obelix.views.not_active'),    
	url(r'^accounts/logout/$', 'obelix.views.logout'),
	url(r'^accounts/loggedin/$', 'obelix.views.loggedin'),
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
    
	)


            
