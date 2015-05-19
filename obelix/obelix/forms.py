from django import forms
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm
from dispense.models import Studente, Bannato

class RegistrationForm(UserCreationForm):
	email = forms.EmailField(required=True, widget=forms.TextInput(attrs={'placeholder': '@studenti.unimore.it '}))
	first_name = forms.CharField(required=True, label="Nome")
	last_name = forms.CharField(required=True, label="Cognome")
	
	class Meta:
		model = User
		fields = ('first_name', 'last_name', 'email', 'username', 'password1', 'password2')   

	def clean_email(self):
		email = self.cleaned_data["email"]
		
		if email.find("@studenti.unimore.it") == -1 :
			raise forms.ValidationError("Utilizzare email universitaria")
		#else:
		#	return email
		
		try:
			User._default_manager.get(email=email)
		except User.DoesNotExist:
			return email
		raise forms.ValidationError("Email gia' utilizzata")
		
	def clean_username(self):
		username_html = self.cleaned_data['username']
	
		if username_html[0].isdigit():
			raise forms.ValidationError('Numeri non consentiti come primo carattere.')
				
		elif len(username_html) < 3 :
			raise forms.ValidationError('Almeno 3 caratteri.')
				
		return username_html
		 
	def save(self, commit=True):        
		user = super(RegistrationForm, self).save(commit=False)
		user.email = self.cleaned_data['email']
		if commit:
			user.is_active = False
			user.save()
		return user


class ChangeUsernameForm(forms.Form):
	username = forms.CharField(required=True)
		
	def clean_username(self):
		username_html = self.cleaned_data.get('username')
		
		if not username_html:
			raise forms.ValidationError("* Campo obbligatorio")

		try:
			User.objects.get(username=username_html)
		except User.DoesNotExist:
			return username_html
		raise forms.ValidationError("* Username non disponibile")
        
        

class StudenteForm(forms.ModelForm):
	email = forms.EmailField(required=True, widget=forms.TextInput(attrs={'placeholder': '@studenti.unimore.it '}))
	
	class Meta:
		model = Studente
		fields = ('nome', 'cognome', 'email')
    
	def clean_email(self):
		email = self.cleaned_data["email"]
		
		
		if email.find("@studenti.unimore.it") == -1 :
			raise forms.ValidationError("Utilizzare email universitaria")
		else:
			return email
			 
		try:
			User._default_manager.get(email=email)
		except User.DoesNotExist:
			return email
		raise forms.ValidationError("Email gia' utilizzata")
		
class BanForm(forms.ModelForm):
	
	class Meta:
		model = Bannato
		fields = ('motivazione',)
        
        
        
        
        
        
        
