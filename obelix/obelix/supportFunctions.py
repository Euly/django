from dispense.models import UserProfile
from django.shortcuts import render_to_response
from functools import wraps


def bubble_sort(dispense):
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
			#return HttpResponseRedirect('/cdl/all/')
			return render_to_response('ban.html', {'request': request} )

	#wrap.__doc__=function.__doc__
	#wrap.__name__=function.__name__
	return wrap
