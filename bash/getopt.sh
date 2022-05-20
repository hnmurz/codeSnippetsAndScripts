#!/bin/bash

options=$(getopt -o "f:b" -l "foo:,bar" -- "$@")
RC=$?
if [ ${RC} -ne 0 ];then
   echo "Error parsing arguments"
   exit 1
fi

# Set will set the positional arguments of the script. The "-" in the
# command specifies that we are done with options and are now just
# specifying args to put in the position variables.
set -- ${options[@]}
while true; do
   case "${1}" in
      -f | --foo)
         shift
         echo "Found foo, arg=" ${1}
         ;;
      -b | --bar) echo "Found bar"
         ;;
      --)
         shift
         break
         ;;
   esac
   shift
done

