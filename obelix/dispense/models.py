from django.db import models
from time import time
from django.conf import settings
from obelix import settings
from django.contrib import auth
from django.contrib.auth.models import User
from django.utils import timezone
import datetime

# Create your models here.
# Creo la classe Corso che contiene le informazioni relative al corso di
# laurea

class Corso(models.Model):
	titolo = models.CharField(max_length=20)
	descrizione = models.TextField()
	
	def __unicode__(self):
		return self.titolo
	
class Studente(models.Model):
	nome = models.CharField(max_length=70)
	cognome = models.CharField(max_length=50)
	email = models.CharField(max_length=50)
	
	def __unicode__(self):
		return self.nome + " " + self.cognome + " " + str(self.email)
		
		
class Insegnamento(models.Model):
	titolo = models.CharField(max_length=100)
	corso = models.ForeignKey(Corso)
	
	def __unicode__(self):
		return self.titolo

def get_upload_file_name(istance, filename):
	return settings.UPLOAD_FILE_PATTERN % (str(time()).replace('.','_'),filename)

class UserProfile(models.Model):
	user = models.OneToOneField(User)
	activation_key = models.CharField(max_length=40, blank=True)
	key_expires = models.DateTimeField(default=datetime.date.today())
	not_globali = models.BooleanField(default=True)
	
	def __str__(self):
		return self.user.username

	class Meta:
		verbose_name_plural=u'User profiles'

class Notifica (models.Model):
	#ogni dispensa la collego agli user_profiles iscritti
	destinatari = models.ManyToManyField(UserProfile)
	controllo = models.IntegerField(default=True) ;

class Dispensa(models.Model):
	insegnamento = models.ForeignKey(Insegnamento)
	#di chi era la dispensa nella visualizzazione
	utente = models.ForeignKey(User) 
	
	titolo = models.CharField(max_length=100)
	descrizione = models.TextField()
	data_pub = models.DateTimeField('Data pubblicazione')
	documento = models.FileField(upload_to=get_upload_file_name)
	
	mi_piace = models.PositiveIntegerField(default=0)
	non_mi_piace = models.PositiveIntegerField(default=0)
	notifica = models.OneToOneField(Notifica)
		
	def __unicode__(self):
		return self.titolo
		
class Opinione(models.Model):
	utente = models.ForeignKey(User)
	dispensa = models.ForeignKey(Dispensa)
	positiva = models.BooleanField(default=False)
	negativa = models.BooleanField(default=False)
		

class Commentarium (models.Model):
	utente = models.ForeignKey(User)
	dispensa = models.ForeignKey(Dispensa)
	commento = models.TextField()
	data_pub = models.DateTimeField(auto_now_add=True)
	

