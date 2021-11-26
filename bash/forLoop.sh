#!/bin/bash

echo "Looping between 0-3"
for i in {0..3}; do
   printf "i=%d, " ${i}
done
printf "\n"

echo -e "\nLooping through array"
foo=(foo bar baz)
for i in ${foo[@]}; do
   printf "i=%s, " ${i}
done
printf "\n"

echo -e "\nLooping through array indices using seq"
foo=(foo bar baz)
for i in $(seq 1 ${#foo[@]}); do
   printf "foo[%s]=%s, " ${i-1} ${foo[i-1]}
done
printf "\n"

echo -e "\nLooping through array indices using just bash"
foo=(foo bar baz)
# (( is a ksh extension that bash supports, see:
# https://unix.stackexchange.com/questions/306111/what-is-the-difference-between-the-bash-operators-vs-vs-vs
for ((i=0;i<${#foo[@]};i++)); do
   printf "foo[%s]=%s, " ${i} ${foo[i]}
done
printf "\n"
