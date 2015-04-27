

def bubble_sort(alist):
	for passnum in range(len(alist)-1,0,-1):
		for i in range(passnum):
			if alist[i].mi_piace - alist[i].non_mi_piace < alist[i+1].mi_piace - alist[i+1].non_mi_piace :
				temp = alist[i]
				alist[i] = alist[i+1]
				alist[i+1] = temp
