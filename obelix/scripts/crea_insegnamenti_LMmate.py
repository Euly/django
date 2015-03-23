# scripts/crea_insegnamenti_LMmate.py

from dispense.models import Corso, Insegnamento

# recupero il riferimento al CdL LM-Matematica
LMmate = Corso.objects.get(titolo="LM-Matematica")
	
# creo gli insegnamenti del CdL matematica magistrale
insegnamento = Insegnamento(titolo="", corso=LMmate)
insegnamento.save()
