
# Глубина вложенности вызовов
depth = 0


# Вывод при входе в функцию
def printIn(s):
    global depth
    print("    " * depth + "In: " + s)
    depth += 1


# Вывод при выходе из функции
def printOut(s):
    global depth
    depth -= 1
    print("    " * depth + "Out: " + s)


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
def factorial(n):
    printIn(f"factorial({n})")

    if n == 0:
        result = 1
    else:
        result = n * factorial(n - 1)

    printOut(f"factorial({n}) = {result}")
    return result


if __name__ == "__main__":
    number = int(input("Введите число для вычисления факториала: "))

    if number < 0:
        print("Ошибка: число должно быть неотрицательным.")
    else:
        print("Факториал с помощью цикла:", factorial_loop(number))
        print("Факториал с помощью рекурсии:", factorial_recursive(number))

        print("\nОтладочная информация:")
        depth = 0
        result = factorial(number)
        print("Факториал =", result)
