from django.conf.urls import patterns, include, url

# Creo gli url raggiungibili dal sito
urlpatterns = patterns ('',

		
	url(r'^all/$', 'dispense.views.cdl'),
	url(r'^(?P<titolo_cdl>\w+-\w+)/$', 'dispense.views.insegnamento'),
	url(r'^(?P<titolo_cdl>\w+-\w+)/(?P<titolo_ins>[\w+|\s*|\']*)/(?P<ordine>|cron_reverse|likes)$', 'dispense.views.dettaglio_insegnamento'),
	url(r'^(?P<titolo_cdl>\w+-\w+)/(?P<titolo_ins>[\w+|\s*|\']*)/aggiungi/$', 'dispense.views.aggiungi_dispensa'),
	url(r'^(?P<titolo_cdl>\w+-\w+)/(?P<titolo_ins>[\w+|\s*|\']*)/assets/uploaded_files/(?P<titolo_file>[\d+|\_|\-|\w+|\/|\.|\s]*)/$', 'dispense.views.scarica'),
	url(r'^(?P<titolo_cdl>\w+-\w+)/(?P<titolo_ins>[\w+|\s*|\']*)/cancella/(?P<dispensa_id>\d+)/$', 'dispense.views.cancella_dispensa'),
	url(r'^(?P<titolo_cdl>\w+-\w+)/(?P<titolo_ins>[\w+|\s*|\']*)/(?P<flag>like|unlike)/(?P<dispensa_id>\d+)/$', 'dispense.views.like_dispensa'),
	url(r'^(?P<titolo_cdl>\w+-\w+)/(?P<titolo_ins>[\w+|\s*|\']*)/commento/(?P<dispensa_id>\d+)/$', 'dispense.views.aggiungi_commento'),
	url(r'^(?P<titolo_cdl>\w+-\w+)/(?P<titolo_ins>[\w+|\s*|\']*)/rimuovi/(?P<commento_id>\d+)/$', 'dispense.views.rimuovi_commento'),
	url(r'^(?P<titolo_cdl>\w+-\w+)/(?P<titolo_ins>[\w+|\s*|\']*)/(?P<dispensa_id>\d+)/segnalazione/$', 'dispense.views.segnalazione')	
)
