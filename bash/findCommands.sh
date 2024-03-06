#!/bin/bash

echo "Do not execute this script. Inspect it's contents for examples."
exit 1;

# Invoking find with an -exec flag. Note, if using the -or command
# then we need to wrap the conditionals in escaped parens
find . \( -name "*.bb" -or -name "*inc" \) -exec grep --color=auto -in "bz2" {} \+

# excluding certain names
find . -name "*.c" -not -name "*.cint"

# exclude certain paths
find . -name "*.h" -not -path "*/cint/*"
# The not must be included for each clause. I.e:
find . -name "*.h" -not -path "*/cint/*" -or -name "*.c" -not -path "*/cint/*"

# printing just filename without path

find . -printf "%f\n"
