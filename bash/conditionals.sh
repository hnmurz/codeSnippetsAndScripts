#!/bin/bash

# multiple conditionals
if [ 1 -gt 5 ] && [1 -lt 5 ]; then
   echo "Foo"
fi

if ls &>/dev/null; then
   echo "Command success!"
fi

shopt -s nullglob
if [ ! -z test/* ]; then
   echo "Command2 success!"
fi
