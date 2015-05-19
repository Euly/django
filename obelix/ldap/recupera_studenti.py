import subprocess
from dispense.models import Studente

file_ldap = ["ldap/fis.txt", "ldap/fis2.txt", "ldap/info.txt", "ldap/info2.txt", "ldap/mate.txt", "ldap/mate2.txt"]

#with open("studenti.txt", "w") as s:
#	for f in file_ldap:
#		with open(f, 'r') as l:
#			s.write(l.read())
with open("studenti.txt", "w") as s:
	with open(file_ldap[2], 'r') as l:
		s.write(l.read())

studenti = subprocess.check_output("sed -n 's/gecos: \|sn: \|unimoremailprincipale: \|^$//p' studenti.txt", shell=True)
studenti = studenti[1:len(studenti)]
studenti = studenti.split("\n\n")
studenti = studenti[:len(studenti)-1]

lista = []

for s in studenti:
	a = s.split("\n")
	if len(a) > 2 :
		lista.append(a)

studenti = []

for l in lista:
	if l[0].find(l[1]) == -1 :
		if l[1].find(l[0]) != -1 :
			l[0] , l[1] = l[1] , l[0]
			l[0] = l[0].replace(" "+l[1], "")
			studenti.append(l)
	else:
		if l[1].find(l[0]) == -1 :
			if l[0].find(l[1]) != -1 :
				l[0] = l[0].replace(" "+l[1], "")
				studenti.append(l)

"""
sostituire file fis.txt, fis2,txt, info.txt, info2.txt, mate.txt, 
mate2.txt in obelix/ldap/

da mettere alla fine di recupera_studenti.py (da riga 37)
"""

vecchi, nuovi= [], []

for v in Studente.objects.all():
	vecchi.append(v)

nuovi = studenti # metto dentro a nuovi tutti gli studenti recuperati dai file

for n in nuovi:
	if n in vecchi:
		s = Studente.objects.get(email=n[2])
		vecchi.remove(s)

# sono rimasti solo gli studenti da rimuovere e "bloccare"
for r in vecchi:
	try:
		u = User.objects.get(email=r[2])
		up = UserProfile.objects.get(user=u)
		up.registrabile = False
		u.is_active = False
		u.save()
		up.save()
	except:
		pass

# cancello la tabella degli studenti vecchi per rimpiazzarla con la nuova	
Studente.objects.all().delete()

for s in nuovi:
	stud = Studente.objects.create(nome=s[0], cognome=s[1], email=s[2])
	stud.save()
