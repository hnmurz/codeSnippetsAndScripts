#!/bin/bash
# Lots of info: https://tldp.org/LDP/abs/html/parameter-substitution.html
#
# Here is a good reference:
# https://stackoverflow.com/questions/19482123/extract-part-of-a-string-using-bash-cut-split

echo "This script is not meant to be executed"
exit

# Here is a for loop to change a file extension from .gz to .txt for all files in the dir
for file in ./*; do
   mv ${file} ${file/\.gz/\.txt}
done

for file in ./*; do
   mv ${file} ${file/2023.*/\.txt}
done


# Checking if a variable is defined:
if [ -z ${foo+x} ]; then
   echo "foo is not defined"
fi
# If foo is defined, it substitutes x for its value. This catches empty variable definitions


#       ${parameter:-word}
#              Use Default Values.  If parameter is unset or null, the
#              expansion of word is substituted.  Otherwise, the value
#              of parameter is substituted.
tmp1=${foo:-"not defined"}
echo ${tmp1}

for file in ./*CustomLed*; do
   mv ${file} ${file/Unit0/};
   # echo "mv ${file} ${file/Unit0/}"
done
echo ""
