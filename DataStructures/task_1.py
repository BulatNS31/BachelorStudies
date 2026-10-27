array = [34, 12, 5, 67, 23, 89, 1, 45, 78, 10]

print("Исходный массив:", array)

def bubble_sort(arr):
	n = len(arr)
	for i in range(n):
		for j in range(0, n-i-1):
			if arr[j] > arr[j+1]:
				arr[j], arr[j+1] = arr[j+1], arr[j]

bubble_sort(array)

print("Отсортированный массив:", array)