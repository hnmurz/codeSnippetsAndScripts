#!/bin/bash 

declare -A foo
echo -e "Populating foo associative array"
foo["a"]=1
foo["b"]=2
foo["c"]=3
foo["d"]=4

echo -e "\nTo print all values:"
echo "\${foo[@]}  :" ${foo[@]}

echo -e "\nTo print all keys"
echo "\${!foo[@]} :" ${!foo[@]}

echo -e "\nAccessing elements with variabls"
i="a"
echo "i=\"a\""
echo "\${foo[\$i]} :" ${foo[$i]}

#checking if element exists
if [[ ${foo["a"]} ]]; then
   echo "foo[\"a\"] exists"
fi

