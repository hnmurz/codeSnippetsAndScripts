#!/bin/bash

foo="AAAA"
bar=foo

printf "%s\n" ${bar}
printf "%s\n" ${!bar}

# we can check if the variable pointer to by bar is set with
if [ -z ${!bar+x} ]; then
   echo "${bar} is not defined"
fi

# Expanding indirect array
foo=(1 2 3)
bar=foo
eval expand=(\${${bar}[@]})
echo ${expand[@]}
