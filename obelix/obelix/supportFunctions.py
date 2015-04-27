

def bubble_sort(dispense):
	for i in range(len(dispense)-1,0,-1):
		for i in range(i):
			if dispense[i].mi_piace - dispense[i].non_mi_piace < dispense[i+1].mi_piace - dispense[i+1].non_mi_piace :
				temp = dispense[i]
				dispense[i] = dispense[i+1]
				dispense[i+1] = temp
