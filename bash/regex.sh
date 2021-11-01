#! /bin/bash

function regex_test()
{
    # Grab the first word before a comma
    if [[ ${foo} =~ ([a-zA-Z]+), ]]; then
        echo "Before the comma, I found the word: \"${BASH_REMATCH[1]}\""
    else
        echo "Didn't find a match!"
    fi
}

foo="This is my string, I like it very much!"
echo "Test string: ${foo}"
regex_test
echo -en "\n"


foo="This is my string; I like it very much!"
echo "Test string: ${foo}"
regex_test
echo -en "\n"
