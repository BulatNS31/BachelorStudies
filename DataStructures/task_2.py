array = [34, 12, 5, 67, 23, 89, 1, 45, 78, 10]

print("Исходный массив:", array)

def find_minimum(arr):
	min_element = arr[0]
	
	for num in arr:
		if num < min_element:
			min_element = num
			
	return min_element

minimum = find_minimum(array)

print("Минимальный элемент массива:", minimum)