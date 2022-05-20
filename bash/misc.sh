#!/bin/bash

# Checking if var is defined
if [[ -v foo ]]; then
   echo "foo is defined"
fi

# Checking if a variable is defined:
if [ -z ${foo+x} ]; then
   echo "foo is not defined"
fi
# If foo is defined, it substitutes x for its value. This catches empty variable definitions

# Check if function exists
if [[ $(type -t foobar) == function ]]; then
   echo "Fn exists"
fi

# if command with a function
if ! echo "hi" | grep hi; then
   echo "not found"
fi
if command -v perl &> /dev/null && [ 1 -eq 2 ]; then
   echo "found perl";
fi
