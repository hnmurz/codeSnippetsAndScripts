#!/bin/bash

optString="fb"
opt=""

while getopts ${optString} opt; do
   case "$opt" in
      f)
         echo "Received f"
         ;;
      b)
         echo "Received b"
         ;;
      *)
         echo "Unknown"
         exit 1
         ;;
   esac
done


