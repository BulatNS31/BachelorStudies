
def fibonacci(n):
	if n == 0:
		return 0

	# Вычисление чисел Фибоначчи для положительных индексов
	a, b = 0, 1

	for i in range(abs(n)):
		a, b = b, a + b

	# Для отрицательных индексов:
	# F(-n) = (-1)^(n+1) * F(n)
	if n < 0 and abs(n) % 2 == 0:
		return -a

	return a


if __name__ == "__main__":
	number = int(input("Введите индекс числа Фибоначчи: "))
	print(f"F({number}) = {fibonacci(number)}")
