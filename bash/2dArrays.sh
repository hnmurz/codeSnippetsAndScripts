#!/bin/bash

# Nice refernce: https://stackoverflow.com/questions/41966140/how-can-i-make-an-array-of-lists-or-similar-in-bash


array=(
   " item1_1
item1_2
"
   "item2_1"
   "item3_1
 item3_2
 item3_3")

countI=0
# IMPORTANT: You must quote the varaible expansion
for i in "${array[@]}"; do
   countJ=0
   for j in ${i}; do
      echo "i=${countI}, j=${countJ}, value=${j}"
      ((countJ++))
   done
   let "countI++"
done

