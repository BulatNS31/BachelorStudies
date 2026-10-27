
class TuringMachine:
    def __init__(self, tape, initial_state='q0', final_state='qf'):
        self.tape = list(tape)
        self.head = 0
        self.state = initial_state
        self.final_state = final_state
        self.transitions = {}

    def add_transition(self, state, symbol, new_state, write_symbol, move_direction):
        self.transitions[(state, symbol)] = (new_state, write_symbol, move_direction)

    def step(self):
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


def add_birthdate_to_surname(surname, birthdate):
    tm = TuringMachine(tape=birthdate + surname)

    tm.add_transition('q0', ' ', 'qf', ' ', 'R')

    tm.run()

    return tm.get_tape()

surname = "Насыров"
birthdate = "31082003"
print(f"Фамилия: {surname}")
print(f"Дата рождения: {birthdate}")
result = add_birthdate_to_surname(surname, birthdate)
print(f"Результат: {result}")
