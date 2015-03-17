from django.conf.urls import patterns, include, url

# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()

urlpatterns = patterns('',
	url(r'^dispense/', include('dispense.urls')),
    #url(r'^admin/', include(admin.site.urls)),
    url(r'^accounts/login/$',  'dispense.views.login'),
    url(r'^accounts/auth/$',  'dispense.views.auth_view'),    
    url(r'^accounts/logout/$', 'dispense.views.logout'),
    url(r'^accounts/loggedin/$', 'dispense.views.loggedin'),
    url(r'^accounts/invalid/$', 'dispense.views.invalid_login'),    
    url(r'^accounts/register/$', 'dispense.views.register_user'),
    url(r'^accounts/register_success/$', 'dispense.views.register_success'),
)
