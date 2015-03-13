from django.conf.urls import patterns, include, url

# Creo gli url raggiungibili dal sito
urlpatterns = patterns ('',
	url(r'^all/$', 'dispense.views.dispense'),
	url(r'^LT-Fisica/anno/$', 'dispense.views.anno'),
	#url(r'^(?P<dispense_titolo>)/(anno?P<dispense_anno>[1-3]{1})/$', 'dispense.views.corso'),
	#url(r'^(?P<dispense_titolo>)/anno?P<dispense_anno>[1-3]{1}/$', 'dispense.views.corso'),
	#url(r'^(?P<dispense_titolo>)/anno?P<dispense_anno>[1-2]{1}/$', 'dispense.views.corso'),
	#url(r'^(?P<dispense_titolo>)/anno?P<dispense_anno>[1-2]{1}/$', 'dispense.views.corso'),
	
	# Usi futuri (magistrale informatica)
	#url(r'^LM-Informatica/anno?P<dispense_anno>[1-2]{1}/$', 'dispense.views.corso'),
)
