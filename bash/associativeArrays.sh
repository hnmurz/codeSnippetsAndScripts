#!/bin/bash 

declare -A foo
echo -e "Populating foo associative array\n"
foo["a"]=1
foo["b"]=2
foo["c"]=3
foo["d"]=4

echo "To print all values:"
echo "\${foo[@]} : " ${foo[@]}

echo "To print all keys"
echo "\${!foo[@]} : " ${!foo[@]}
