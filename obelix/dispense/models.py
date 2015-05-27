from django.db import models
from time import time
from django.conf import settings
from obelix import settings
from django.contrib import auth
from django.contrib.auth.models import User
from django.utils import timezone
import datetime

# Corso di Laurea 
class Corso(models.Model):
	titolo = models.CharField(max_length=20)
	descrizione = models.TextField()
	
	def __unicode__(self):
		return self.titolo

# Studente presente nel database di LDAP
class Studente(models.Model):
	nome = models.CharField(max_length=70)
	cognome = models.CharField(max_length=50)
	email = models.CharField(max_length=50)
	
	def __unicode__(self):
		return self.nome + " " + self.cognome + " " + str(self.email)
		
# Insegnamento relativo ad un dato corso di Laurea
class Insegnamento(models.Model):
	titolo = models.CharField(max_length=100)
	corso = models.ForeignKey(Corso)
	
	def __unicode__(self):
		return self.titolo

# User esteso per poter avere funzionalita' aggiuntive 
class UserProfile(models.Model):
	user = models.OneToOneField(User)
	activation_key = models.CharField(max_length=40, blank=True)
	key_expires = models.DateTimeField()
	not_globali = models.BooleanField(default=True)
	ban = models.BooleanField(default=False)
	registrabile = models.BooleanField(default=True)
	
	def __str__(self):
		return self.user.username

	class Meta:
		verbose_name_plural=u'User profiles'

# Notifiche relative alle dispense seguite, commentate o caricate da un utente
class Notifica (models.Model):
	#ogni dispensa la collego agli user_profiles iscritti
	destinatari = models.ManyToManyField(UserProfile)
	controllo = models.IntegerField(default=True) ;

# Funzione che permette l'upload di un file nel sistema
def get_upload_file_name(istance, filename):
	return settings.UPLOAD_FILE_PATTERN %(str(time()).replace('.','_'),filename)

# File da caricare o da visualizzare nel relativo insegnamento di un dato corso
class Dispensa(models.Model):
	insegnamento = models.ForeignKey(Insegnamento)
	utente = models.ForeignKey(User) 
	
	titolo = models.CharField(max_length=100)
	descrizione = models.TextField()
	data_pub = models.DateTimeField()
	documento = models.FileField(upload_to=get_upload_file_name)
	mi_piace = models.PositiveIntegerField(default=0)
	non_mi_piace = models.PositiveIntegerField(default=0)
	notifica = models.OneToOneField(Notifica)
	
	num_com = models.IntegerField(default=0)
	eliminabile = models.BooleanField(default=True)
		
	def __unicode__(self):
		return self.titolo

# Giudizio espresso da un dato utente relativo ad una dispensa
class Opinione(models.Model):
	utente = models.ForeignKey(User)
	dispensa = models.ForeignKey(Dispensa)
	positiva = models.BooleanField(default=False)
	negativa = models.BooleanField(default=False)
		
# Commento di una data dispensa da parte di un utente registrato
class Commentarium (models.Model):
	utente = models.ForeignKey(User)
	dispensa = models.ForeignKey(Dispensa)
	commento = models.TextField()
	data_pub = models.DateTimeField(auto_now_add=True)

# Segnalazione di un utente da parte di un altro utente all'amministratore
class Segnalazione (models.Model):
	accusatore = models.ForeignKey(UserProfile)
	dispensa = models.ForeignKey(Dispensa)
	motivazione = models.TextField()

# Utente bannato per una segnalazione dall'amministratore di sistema
class Bannato (models.Model) :
	user_profile = models.ForeignKey(UserProfile)
	motivazione = models.TextField()
	
