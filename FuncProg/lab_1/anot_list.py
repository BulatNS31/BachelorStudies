
def get_function_annotations(*functions):
	result = {}

	for func in functions:
		result[func.__name__] = func.__annotations__

	return result


# Примеры функций с аннотациями
def add(a: int, b: int) -> int:
	return a + b


def greet(name: str) -> str:
	return "Привет, " + name


def is_positive(n: int) -> bool:
	return n > 0


if __name__ == "__main__":
	annotations = get_function_annotations(
		add,
		greet,
		is_positive
	)

	print(annotations)
