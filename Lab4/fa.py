class DFA:
    def __init__(self, states, alphabet, transitions, initial_state, final_states):
        self.states = set(states)
        self.alphabet = set(alphabet)
        self.transitions = transitions
        self.initial_state = initial_state
        self.final_states = set(final_states)

    def is_accepted(self, sequence):
        current_state = self.initial_state

        for char in sequence:
            if (current_state, char) not in self.transitions:
                return False

            current_state = self.transitions[(current_state, char)]

        return current_state in self.final_states


def read_fa_from_file(file_path):
    with open(file_path, 'r') as file:
        content = file.readlines()

    states = content[0].split('{')[1].split('}')[0].split(', ')
    alphabet = content[1].split('{')[1].split('}')[0].split(', ')

    transitions_raw = content[2].split('{')[1].split('}')[0].split('; ')
    transitions = {}
    for transition in transitions_raw:
        from_state, to_state, symbol = transition.split("(")[1].split(")")[0].split(", ")
        transitions[(from_state, symbol)] = to_state
    
    initial_state = content[3].split('=')[1].split('\n')[0]
    final_state = content[4].split('{')[1].split('}')[0].split(', ')

    return DFA(states, alphabet,transitions, initial_state, final_state)


def display_fa_elements(dfa):
    print("States:", ', '.join(dfa.states))
    print("Alphabet:", ', '.join(dfa.alphabet))
    print("Transitions:")
    for (from_state, symbol), to_state in dfa.transitions.items():
        print(f"  {from_state}, {symbol} -> {to_state}")
    print("Initial State:", dfa.initial_state)
    print("Final States:", ', '.join(dfa.final_states))


if __name__ == "__main__":
    dfa = read_fa_from_file("int.in")
    while True:
        print("\nMenu:")
        print("0. Take input from a file")
        print("1. Display set of states")
        print("2. Display alphabet")
        print("3. Display all transitions")
        print("4. Display initial state")
        print("5. Display final states")
        print("6. Verify sequence acceptance")
        print("7. Exit")

        choice = input("Enter your choice: ")

        if choice == "0":
            file_path = input("Enter file name: ")
            try:
                dfa = read_fa_from_file(file_path)
            except:
                print("\n!!! Bad file\n")
        elif choice == "1":
            print("Set of States:", ', '.join(dfa.states))
        elif choice == "2":
            print("Alphabet:", ', '.join(dfa.alphabet))
        elif choice == "3":
            print("Transitions:")
            for (from_state, symbol), to_state in dfa.transitions.items():
                print(f"  {from_state}, {symbol} -> {to_state}")
        elif choice == "4":
            print("Initial State:", dfa.initial_state)
        elif choice == "5":
            print("Set of Final States:", ', '.join(dfa.final_states))
        elif choice == "6":
            sequence = input("Enter a sequence to verify: ")
            if dfa.is_accepted(sequence):
                print("Sequence is accepted.")
            else:
                print("Sequence is not accepted.")
        elif choice == "7":
            break
        else:
            print("Invalid choice. Please try again.")
