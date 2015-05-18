
from django.contrib.auth.models import User
from django.test import TestCase
from django.utils import unittest
from dispense.models import Corso, Dispensa, Commentarium, UserProfile, Segnalazione, Notifica


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
