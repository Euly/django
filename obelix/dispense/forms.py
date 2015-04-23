from django import forms
from models import Dispensa, Commentarium


class DispensaForm(forms.ModelForm):
	
	class Meta:
		model = Dispensa
		fields = ('titolo', 'descrizione', 'documento')


class CommentariumForm(forms.ModelForm):
	
	class Meta:
		model = Commentarium
		fields = ('scriptum',)
        
