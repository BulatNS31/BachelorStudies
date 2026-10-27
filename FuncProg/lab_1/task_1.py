# 1. Факториал с помощью цикла
def factorial_loop(n):
	result = 1
	for i in range(1, n + 1):
		result *= i
	return result


# 2. Факториал с помощью рекурсии
def factorial_recursive(n):
	if n == 0:
		return 1
	return n * factorial_recursive(n - 1)


# 3. Рекурсия с отладочной информацией
depth = 0

def factorial(n):
	global depth

	print("    " * depth + f"factorial({n})")
	depth += 1

	if n == 0:
		result = 1
	else:
		result = n * factorial(n - 1)

	depth -= 1
	return result


if __name__ == "__main__":
	number = int(input("Введите число для вычисления факториала: "))
	print("Факториал с помощью цикла:", factorial_loop(number))
	print("Факториал с помощью рекурсии:", factorial_recursive(number))

	print("\nОтладочная информация:")
	depth = 0
	print("In: factorial(4)")
	print()
	print("Факториал =", factorial(4))
