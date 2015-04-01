from django import forms
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm

class Registrazione(UserCreationForm):
	matricola = forms.IntegerField(required=True)
	username = forms.CharField(required=True)
	
	class Meta:
		model = User
		fields = ('first_name', 'last_name', 'matricola', 'username','password1', 'password2')

def save(self, commit=True):
        user = super(Registrazione, self).save(commit=False)
        user.matricola = self.cleaned_data['matricola']
        user.username = self.cleaned_data['username']
        user.set_password(self.cleaned_data['password1'])
        
        if commit:
            user.save()
            
        return user
