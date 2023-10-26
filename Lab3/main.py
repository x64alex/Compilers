class HashTable:
    # Separate chaining
	def __init__(self, size):
		self.size = size
		self.hash_table = self.create_empty()

	def create_empty(self):
		return [[] for _ in range(self.size)]

	def __get_hash(self, key):
        # h(x) = sum(x)^2 / len(x)
		return sum(ord(char) for char in key) **2 // len(key)

	def insert(self, key, val):
		hashed_key = self.__get_hash(key) % self.size
		bucket = self.hash_table[hashed_key]
		bucket.append((key, val))


	def lookup(self, key):
		hashed_key = self.__get_hash(key) % self.size
		bucket = self.hash_table[hashed_key]

		found_key = False
		for index, record in enumerate(bucket):
			record_key, record_val = record
			
			if record_key == key:
				found_key = True
				break

		if found_key:
			return record_val
		else:
			return "No record found"

	def delete_value(self, key):
		hashed_key = self.__get_hash(key) % self.size
		bucket = self.hash_table[hashed_key]

		found_key = False
		for index, record in enumerate(bucket):
			record_key, record_val = record

			if record_key == key:
				found_key = True
				break
		if found_key:
			bucket.pop(index)
		return

	def __str__(self):
		return "".join(str(item) for item in self.hash_table)

# We will analyze the following program
# int x;
# string y;
# bool z;

symbol_table = HashTable(10)

# We execute the first line
symbol_table.insert('x', 'int')
symbol_table.insert('x', 'string')

print(symbol_table)
print(symbol_table.lookup('x'))
print(symbol_table.lookup('y'))
# We get int for x and no value for y because we have


print(symbol_table)
