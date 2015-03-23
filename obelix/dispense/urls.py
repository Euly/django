from django.conf.urls import patterns, include, url

# Creo gli url raggiungibili dal sito
urlpatterns = patterns ('',
	url(r'^all/$', 'dispense.views.cdl'),
	url(r'^(?P<titolo_cdl>\w+-\w+)/$', 'dispense.views.insegnamento'),
	url(r'^(?P<titolo_cdl>\w+-\w+)/(?P<titolo_ins>[\w+\s*]*)/$', 'dispense.views.dettaglio_insegnamento'),
	url(r'^(?P<titolo_cdl>\w+-\w+)/(?P<titolo_ins>[\w+\s*]*)/aggiungi/$', 'dispense.views.aggiungi_dispensa'),
)
