
from dispense.models import Corso, Dispensa, Commentarium, UserProfile, Segnalazione, Notifica
from django.contrib.auth.models import User
from django.core.urlresolvers import resolve
from django.http import HttpRequest
from django.test.client import Client
from django.test import TestCase
from django.utils import unittest
from obelix.views import profilo_utente, segnalazioni, dispense_globali, volumica
from dispense.views import dettaglio_insegnamento


class DispenseModelsTestCase(TestCase):
	fixtures = ['obelixtest.json']
	
	def test_corso(self):	
		#test esistenza corso		
		self.assertTrue(Corso.objects.get(titolo="LT-INFORMATICA"))
		
		#test esistenza corso (non presente)
		self.assertFalse(Corso.objects.filter(titolo="LM-INFORMATICA"))
		
		
	def test_utente(self):
		#test esistenza User SU
		self.assertTrue(User.objects.filter(email='obelix.fim@gmail.com'))
		
	def test_profilo_utente(self):
		#test esistenza UserProfile SU
		self.assertTrue(UserProfile.objects.get(pk=1))
		self.assertEqual(UserProfile.objects.get(pk=1).user.username, 'obelix')
		
	
	def test_dispensa(self):
		#test esistenza dispensa_1 
		self.assertTrue(Dispensa.objects.get(pk=1))
		
		#test esistenza dispensa_2 
		self.assertTrue(Dispensa.objects.get(pk=2))
	
		#test esistena dispensa_800 (non presente)
		self.assertFalse(Dispensa.objects.filter(pk=800))
		
		
		#test esistenza commento
		self.assertEqual(Dispensa.objects.get(pk=1).num_com, 1)
		
		#testa esistenza autore dispensa 
		self.assertEqual(Dispensa.objects.get(pk=1).utente.username, 'pap')
		
	
	def test_commento(self):
		#test esistenza commento_1
		self.assertTrue(Commentarium.objects.get(pk=1))
		
		#test relazione commento__1 a dispensa_1
		self.assertEqual(Commentarium.objects.get(pk=1).dispensa.id, 1)
		

	def test_segnalazione(self):
		#test esistenza segnalazione_1
		self.assertTrue(Segnalazione.objects.get(pk=1))
		
		#test esistenza segnalazione relativa a dispensa_!
		self.assertTrue(Segnalazione.objects.get(pk=1).dispensa.id, 1)
		
		
	def test_notifica(self):
		#test attivazione notifica per SU per dispensa_1
		self.assertTrue(Notifica.objects.get(pk=1).destinatari , 1)


class DispenseViewsTestCase(TestCase):
	fixtures = ['obelixtest.json']
	
	
	#testa url non valida
	def test_url_Not_Found(self):	
		resp = self.client.get('/fuoricontrollo/')
		self.assertEqual(resp.status_code, 404)
	
	#testa views di risposta 	
	def test_url_profilo_utente(self):
		found = resolve('/accounts/profilo_utente/')
		self.assertEqual(found.func, profilo_utente)
		
	def test_url_dispense(self):
		found = resolve('/cdl/LT-Informatica/Linguaggi dinamici/recenti/')
		self.assertEqual(found.func, dettaglio_insegnamento )
	
	def test_url_segnalazione(self):
		found = resolve('/accounts/profilo_utente/superuser/segnalazioni/')
		self.assertEqual(found.func, segnalazioni)
	
	def test_url_dispense_globali(self):
		found = resolve('/accounts/profilo_utente/superuser/dispense/pub/')
		self.assertEqual(found.func, dispense_globali)
	
	def test_login (self):
		c = Client()
		
		#post su login, indirizzo sbagliato
		response = c.post('/login/', {'username': 'obelix', 'password': 'dbdjob@'})
		self.assertEqual(response.status_code, 404)
	
		#post su login, indirizzo ok
		response = c.post('/accounts/login/', {'username': 'obelix', 'password': 'dbdjob@'})
		self.assertEqual(response.status_code, 200)
	
		#inserire template di ritorno
	









