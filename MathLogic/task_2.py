class TuringMachine:
	def __init__(self, tape, initial_state='q0', final_state='qf'):
		self.tape = list(tape + ' ')  # Добавляем пробел для дополнительных символов
		self.head = len(tape)  # Начинаем работу с конца фамилии
		self.state = initial_state
		self.final_state = final_state
		self.transitions = {}

	def add_transition(self, state, symbol, new_state, write_symbol, move_direction):
		self.transitions[(state, symbol)] = (new_state, write_symbol, move_direction)

	def step(self):
		# Увеличиваем ленту, если головка выходит за её пределы
		if self.head < 0:
			self.tape.insert(0, ' ')
			self.head = 0
		elif self.head >= len(self.tape):
			self.tape.append(' ')

		current_symbol = self.tape[self.head]
		if (self.state, current_symbol) in self.transitions:
			new_state, write_symbol, move_direction = self.transitions[(self.state, current_symbol)]
			self.tape[self.head] = write_symbol
			self.state = new_state

			if move_direction == 'R':
				self.head += 1
			elif move_direction == 'L':
				self.head -= 1
		else:
			self.state = self.final_state

	def run(self):
		while self.state != self.final_state:
			self.step()

	def get_tape(self):
		return ''.join(self.tape).strip()


def add_initials_to_surname(surname, name, patronymic):
	# Формируем строку для добавления: первая буква имени + первая буква отчества
	initials = name[0] + patronymic[0]  
	tm = TuringMachine(tape=surname)

	# Текущее состояние q0: поочерёдно добавляем символы из initials
	current_state = 'q0'
	for char in initials:
		next_state = f'q{current_state[1:]}_next'
		tm.add_transition(current_state, ' ', next_state, char, 'R')
		current_state = next_state

	# Финальное состояние
	tm.add_transition(current_state, ' ', 'qf', ' ', 'R')

	tm.run()

	return tm.get_tape()


# Ввод данных
surname = "Насыров"
name = "Булат"
patronymic = "Ильшатович"

print(f"Фамилия: {surname}")
print(f"Имя: {name}")
print(f"Отчество: {patronymic}")

# Выполнение программы
result = add_initials_to_surname(surname, name, patronymic)
print(f"Результат: {result}")
