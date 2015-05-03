from django import forms
from models import Dispensa, Commentarium, Segnalazione


class DispensaForm(forms.ModelForm):
	
	class Meta:
		model = Dispensa
		fields = ('titolo', 'descrizione', 'documento')


class CommentariumForm(forms.ModelForm):
	
	class Meta:
		model = Commentarium
		fields = ('commento',)
		
class SegnalazioneForm(forms.ModelForm):
	
	class Meta:
		model = Segnalazione
		fields = ('motivazione',)
