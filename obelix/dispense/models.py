from django.db import models

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
	matricola = models.PositiveIntegerField()
	
	def __unicode__(self):
		return self.nome + " " + self.cognome + " " + str(self.matricola)
		
class Insegnamento(models.Model):
	titolo = models.CharField(max_length=100)
	corso = models.ForeignKey(Corso)
	
	def __unicode__(self):
		return self.titolo

def get_upload_file_name(filename):
	return settings.UPLOAD_FILE_PATTERN % (filename)

class Dispensa(models.Model):
	titolo = models.CharField(max_length=100)
	#documento = models.FileField(upload_to=get_upload_file_name)
	descrizione = models.TextField()
	data = models.DateTimeField('Data pubblicazione')
	#mi_piace = models.PositiveIntegerField(default=0)
	insegnamento = models.ForeignKey(Insegnamento)
	
	def __unicode__(self):
		return self.titolo
