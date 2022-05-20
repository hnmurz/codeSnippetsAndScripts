#!/bin/bash

echo "Inspect the script, do not execute"
exit 1

# Creating a file of a fixed size
dd if=/dev/urandom of=t1 bs=1M count=10 iflag=fullblock
