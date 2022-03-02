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
