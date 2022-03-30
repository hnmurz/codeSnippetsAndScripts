#!/bin/bash

echo "This script doesnt execute anything. Look at it's source for the examples."
exit 0

# This looks for files containing "SomeString" And then changes the
# CFLAGS_append line to have -g
grep -rl "SomeString" . | xargs sed 's/CFLAGS_append.*/CFLAGS_append = \" -g \"/g'

# Using an array of things to replace
toFix=(Foo Bar)
fixed=(foo bar)
for ((i=0;i<${#toFix[@]};i++)); do
   grep -rIl ${toFix[i]} --exclude=scratch* | xargs sed -i "s/${toFix[i]}/${fixed[i]}/"
done
