#!/bin/bash

echo "Do not execute this script. Inspect it's contents for examples."
exit 1;

# Invoking find with an -exec flag. Note, if using the -or command
# then we need to wrap the conditionals in escaped parens
find . \( -name "*.bb" -or -name "*inc" \) -exec grep --color=auto -in "bz2" {} \+
