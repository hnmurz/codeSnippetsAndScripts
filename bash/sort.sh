#!/bin/bash

# Some nifty sort examples
# consider:
foo=(foo_bar_1_2 foo_bar_10_1 foo_bar_2_3 foo_bar_3_5 foo_bar_4_4 foo_bar_5_6 foo_bar_6_7 foo_bar_7_8 foo_bar_8_9 foo_bar_9_10)

echo "Consider foo="
printf "%s\n" ${foo[@]}

echo -e "\nTo sort by the first index:"
echo 'printf "%s\n" ${foo[@]} | sort -n -t "_" -k 3'
printf "%s\n" ${foo[@]} | sort -n -t "_" -k 3

# To sort but the second index:
echo -e "\nTo sort by the second index:"
echo 'printf "%s\n" ${foo[@]} | sort -n -t "_" -k 4'
printf "%s\n" ${foo[@]} | sort -n -t "_" -k 4
