#!/bin/bash 

# Examples of simple array operations.

# Declaring array
echo "Declaring array variable"
array=(1 2 3 4 5 6)
echo -e "array=${array[@]}\n"

# Adding a new element
echo "Appending value to array"
array+=(7)
echo -e "array=${array[@]}\n"

# Sorting array
array=(4 1 6 23 0 6 7 3)
echo "Unsorted array=${array[@]}"
array=(`printf "%s\n" ${array[@]} | sort -n`)
echo -e "Sorted array=${array[@]}\n"

# Cutting array elements
echo "Cutting elements out"
array=(1 2 3 4 5 6 7)
echo ${array[@]}
echo ${array[@]:2}
echo ${array[@]-2}

# Another way to cut array elements
unset 'array[0]'
array=(${array[@]})

echo "Re-assigning arrays"
array=(1 2 3 4)
array=(${array[@]:2})
echo ${array[@]}
array=(${array[@]:7})
echo ${array[@]}
echo ${#array[@]}

array=("foo" "foobar" "baz" "naz" "jazz" "foobaz")
key="foob"
if [[ " ${array[@]} " =~ " ${key} " ]]; then
   echo "Found: ${key}"
else
   echo "Did not find: \"${key}\" in array=(${array[@]})"
fi


# Expanding arrays
array=(1 2 3 4)
# As multiple arguments
echo ${array[@]}
# As one argument
echo ${array[*]}

# Visually, they look the same, but the end result is different when
# we consider the arg number

