from django import forms
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm

class RegistrationForm(UserCreationForm):
	email = forms.EmailField(required=True, widget=forms.TextInput(attrs={'placeholder': '@studenti.unimore.it '}))
	first_name = forms.CharField(required=True)
	last_name = forms.CharField(required=True)
	
	class Meta:
		model = User
		fields = ('first_name', 'last_name', 'email', 'username', 'password1', 'password2')   

	def clean_email(self):
		email = self.cleaned_data["email"]
		
		
		if email.find("@studenti.unimore.it") == -1 :
			raise forms.ValidationError("Utilizzare email universitaria")
		
		#try:
		#	User._default_manager.get(email=email)
		#except User.DoesNotExist:
		#	return email
		#raise forms.ValidationError("Email gia' utilizzata")
		
		
		 
	def save(self, commit=True):        
		user = super(RegistrationForm, self).save(commit=False)
		user.email = self.cleaned_data['email']
		if commit:
			user.is_active = False
			user.save()
		return user


class ChangeUsernameForm(forms.Form):
	new_username = forms.CharField(required=True)
	
	def clean(self):
		username_html = self.cleaned_data.get('new_username')
		
		if not username_html:
			raise forms.ValidationError("* Campo obbligatorio")

		try:
			User.objects.get(username=username_html)
		except User.DoesNotExist:
			return username_html
		raise forms.ValidationError("* Username non disponibile")
		
		
			
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
