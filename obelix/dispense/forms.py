from django import forms
from models import Dispensa

class DispensaForm(forms.ModelForm):
	
	class Meta:
		model = Dispensa
		fields = ('titolo', 'descrizione', 'documento')
