#!/bin/bash
# Here is a good reference:
# https://stackoverflow.com/questions/19482123/extract-part-of-a-string-using-bash-cut-split


# Here is a for loop to change a file extension from .gz to .txt for all files in the dir
for file in ./*; do
   mv ${file} ${file/\.gz/\.txt}
done

# Checking if a variable is defined:
if [ -z ${foo+x} ]; then
   echo "foo is not defined"
fi
# If foo is defined, it substitutes x for its value. This catches empty variable definitions

