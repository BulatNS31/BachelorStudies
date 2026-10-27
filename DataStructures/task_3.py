class Stack:
	def __init__(self, size):
		self.size = size
		self.stack = []
	
	def is_full(self):
		return len(self.stack) == self.size
	
	def is_empty(self):
		return len(self.stack) == 0
	
	def push(self, item):
		if self.is_full():
			print("Стек полон! Невозможно добавить элемент:", item)
		else:
			self.stack.append(item)
			print("Добавлен элемент в стек:", item)
	
	def pop(self):
		if self.is_empty():
			print("Стек пуст! Невозможно извлечь элемент.")
			return None
		else:
			item = self.stack.pop()
			print("Извлечен элемент из стека:", item)
			return item
	
	def peek(self):
		if self.is_empty():
			return None
		return self.stack[-1]

array = [34, 12, 5, 67, 23, 89, 1, 45, 78, 10]
print("Исходный массив:", array)

stack = Stack(10)

for item in array:
	stack.push(item)

print("\nИзвлечение элементов из стека:")
for _ in range(len(array)):
	stack.pop()