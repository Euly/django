from django.conf.urls import patterns, include, url

# Creo gli url raggiungibili dal sito
urlpatterns = patterns ('',
	url(r'^all/$', 'dispense.views.dispense'),
	url(r'^(?P<titolo_cdl>\w+-\w+)/$', 'dispense.views.insegnamento'),
)
