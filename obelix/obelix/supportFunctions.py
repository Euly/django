from dispense.models import UserProfile, Bannato
from django.shortcuts import render_to_response
from django.http import HttpResponseRedirect
from functools import wraps

def bubble_sort_dispense(dispense):
	for i in range(len(dispense)-1,0,-1):
		for i in range(i):
			if dispense[i].mi_piace - dispense[i].non_mi_piace < dispense[i+1].mi_piace - dispense[i+1].non_mi_piace :
				temp = dispense[i]
				dispense[i] = dispense[i+1]
				dispense[i+1] = temp

		
def unbanned_only(function):
	def wrap(request, *args, **kwargs):

		user_profile = UserProfile.objects.get(user_id = request.user.id)
		
		if user_profile.ban == False:
			return function(request, *args, **kwargs)
		else:
			bannato = []
			for ban in Bannato.objects.all():
				if ban.user_profile == user_profile:
					bannato.append(ban)
					
			return render_to_response('ban.html', {'Bannato': bannato, 'user_profile': user_profile, 'request': request})

	#wrap.__doc__=function.__doc__
	#wrap.__name__=function.__name__
	return wrap
