# scripts/crea_insegnamenti_LMfis.py

from dispense.models import Corso, Insegnamento

# recupero il riferimento al CdL LM-Fisica
LMfis = Corso.objects.get(titolo="LM-Fisica")
	
# creo gli insegnamenti del CdL fisica magistrale
insegnamento = Insegnamento(titolo="", corso=LMfis)
insegnamento.save()

