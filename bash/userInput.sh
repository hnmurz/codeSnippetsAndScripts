#!/bin/bash

echo "Reading input"
while read -p "> " userInput; do
   echo "userInput=${userInput}"
   if [[ ${userInput} == "q" ]]; then
      exit 0
   fi
done
