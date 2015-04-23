
@login_required
def cancella_dispensa(request, titolo_cdl, titolo_ins, dispensa_id):
	corso_ins = Corso.objects.get(titolo=titolo_cdl)
	materia = Insegnamento.objects.get(titolo=titolo_ins, corso=corso_ins)
	
	d = Dispensa.objects.get(id=dispensa_id)
	d.delete()
			
	return HttpResponseRedirect('/cdl/%s/%s' %(corso_ins.titolo, materia.titolo))

