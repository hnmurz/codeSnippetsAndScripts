#!/bin/bash

echo "Consider the following string:"
string="<This is a key>: <Here is the value>"
echo ${string}

echo -e "\nTo grab the key:"
echo ${string} | sed 's/^.*: *\(.*\)/\1/'
