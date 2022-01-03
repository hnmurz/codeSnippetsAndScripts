#!/bin/python

# Simple array operators
foo = []

print("Appending \"1\"")
foo.append(1)
print("Appending \"2\"")
foo.append(2)
print("Appending \"3\"")
foo.append(3)
print(foo)

print("Inserting \"4\" to front of list")
foo.insert(0, 4)
print(foo)


print("Inserting \"5\" to index 7. Even though this is out of bound, it will just append it")
foo.insert(7, 5)
print(foo)

print("Replacing item at index 3, (value=3) with \"9\"")
foo.pop(3)
foo.insert(3, 9)
print(foo)

print("Looping over array")
foo = ["a", "b", "c", "d", "e", "f", "g", "h"]
print("Using iterator")
for entry in foo:
    print(entry)
print("Using index")
for i in range(0, len(foo)):
    print(i, foo[i])
    

