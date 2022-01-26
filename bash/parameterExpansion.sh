#!/bin/bash
# Here is a good reference:
# https://stackoverflow.com/questions/19482123/extract-part-of-a-string-using-bash-cut-split


# Here is a for loop to change a file extension from .gz to .txt for all files in the dir
for file in ./*; do
   mv ${file} ${file/\.gz/\.txt}
done
