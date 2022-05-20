#!/bin/bash

count=0
while true; do
   count=$((count+1))
   if [ ${count} -eq 3 ]; then
      break
   fi
   printf ".    \r"
   sleep 0.5
   printf "..   \r"
   sleep 0.5
   printf "...  \r"
   sleep 0.5
   printf ".... \r"
   sleep 0.5
   printf ".....\r"
   sleep 0.5
done
