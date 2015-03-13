from django.db import models

# Create your models here.
# Creo la classe Corso che contiene le informazioni relative al corso di
# laurea
class Corso(models.Model):
	titolo = models.CharField(max_length=20)
	descrizione = models.TextField()
	
	def __unicode__(self):
		return self.titolo

class Anno(models.Model):
	titolo = models.CharField(max_length=20)
	num = models.IntegerField()
	
	def __unicode__(self):
		s = self.titolo + " " + str(self.num)
		return s
