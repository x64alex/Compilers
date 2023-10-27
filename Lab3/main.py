class HashTable:
    # Separate chaining
	def __init__(self, size):
		self.__size = size
		self.__hash_table = [[] for _ in range(self.__size)]

	def get_size(self):
		return self.__size

	def __get_hash(self, key):
        # h(x) = (sum(x)^2 / len(x)) % size
		return (sum(ord(char) for char in key) **2 // len(key)) % self.__size
	
	def exists(self, key):
		hashed_key = self.__get_hash(key)
		return key in self.__hash_table[hashed_key]

	def insert(self, key):
		hashed_key = self.__get_hash(key)
		bucket = self.__hash_table[hashed_key]

		if self.exists(key) is False :
			bucket.append(key)
			position = bucket.index(key)
			return (hashed_key, position)
		return -1

	def lookup(self, key):
		hashed_key = self.__get_hash(key)
		bucket = self.__hash_table[hashed_key]

		if key in bucket:
			position = bucket.index(key)
			return (hashed_key, position)
		else:
			return -1

	def delete(self, key):
		hashed_key = self.__get_hash(key)
		bucket = self.__hash_table[hashed_key]

		if key in bucket:
			position = bucket.index(key)
			bucket.pop(position)
			return (hashed_key, position)
		else:
			return -1

	def __str__(self):
		return "".join(str(item) for item in self.__hash_table)

symbol_table = HashTable(10)

print("Insert " + "x" + " at position: " + str(symbol_table.insert('x')))
print("Insert " + "xy" + " at position: " + str(symbol_table.insert('xy')))
print("Insert " + "xy" + " at position: " + str(symbol_table.insert('xy')))
print("Insert " + "xyz" + " at position: " + str(symbol_table.insert('xyz')))
print("Insert " + "variable" + " at position: " + str(symbol_table.insert('variable')))
print("Insert " + "miau" + " at position: " + str(symbol_table.insert('miau')))

print()
print("Contains " + "xy" + " at position: " + str(symbol_table.lookup('xy')))
print("Remove " + "xy" + " at position: " + str(symbol_table.delete('xy')))

print()
print("Contains " + "variable" + " at position: " + str(symbol_table.lookup('variable')))
print("Remove " + "variable" + " at position: " + str(symbol_table.delete('variable')))

print()
print("Contains " + "variable" + " at position: " + str(symbol_table.lookup('variable')))
print("Remove " + "variable" + " at position: " + str(symbol_table.delete('variable')))

print()
print(symbol_table)
