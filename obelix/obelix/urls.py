from django.conf.urls import patterns, include, url

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
	url(r'^dispense/', include('dispense.urls')),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^accounts/login/$',  'obelix.views.login'),
    url(r'^accounts/auth/$',  'obelix.views.auth_view'),    
    url(r'^accounts/logout/$', 'obelix.views.logout'),
    url(r'^accounts/loggedin/$', 'obelix.views.loggedin'),
    url(r'^accounts/invalid/$', 'obelix.views.invalid_login'),    
    url(r'^accounts/register/$', 'obelix.views.register_user'),
    url(r'^accounts/register_success/$', 'obelix.views.register_success'),
    url(r'^accounts/register_failed/$', 'obelix.views.register_failed'),
)
