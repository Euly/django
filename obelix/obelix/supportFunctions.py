
def quick_sort(items):

	if len(items) > 1:
		pivot_index = len(items) / 2
		smaller_items = []
		larger_items = []

		for i, val in enumerate(items):
			if i != pivot_index:
				if val < items[pivot_index].mi_piace:
					smaller_items.append(val)
				else:
					larger_items.append(val)

		quick_sort(smaller_items)
		quick_sort(larger_items)
		items[:] = smaller_items + [items[pivot_index]] + larger_items
