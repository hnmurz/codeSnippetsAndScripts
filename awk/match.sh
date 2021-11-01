#! /bin/bash

# This will look for $tag, and then toggle the comments on all the lines under it till it hits a
# blank line

if [ ! -e $1 ] || [ -z $1 ]; then
    echo "Expecting a file arg"
    exit 1
fi


awk -v tag="REMOVE_ME" '
function process_text_block(line)
{
    while(getline > 0)
    {
        # If a blank line then move on
        if (match($0, /\S/) == 0)
        {
            return;
        }
        # If there is a comment, remove it
        if (match($0, /^[[:blank:]]*(#)[[:blank:]]*/) != 0)
        {
            $0 = gensub(/#/, "", "1", $0);
            printf("%s%s", $0, RT);
            continue;
        }
        # If this line does not have a comment add a comment
        if (match($0, /^[[:blank:]]*\w/) != 0)
        {
            $0 = gensub(/([[:blank:]]*)(.*)/, "\\1#\\2", "1", $0);
            printf("%s%s", $0, RT);
            continue;
        }
        return
    }
}

BEGIN{
    while(getline > 0)
    {
        # Interesting trick to prevent awk from always appending a newline
        # See: https://www.gnu.org/software/gawk/manual/html_node/Getline-Summary.html
        # and: https://www.gnu.org/software/gawk/manual/html_node/Auto_002dset.html#Auto_002dset
        printf("%s%s", $0, RT);
        if($0 ~ tag)
        {
            process_text_block($0);
            printf("%s%s", $0, RT);
        }
    }
}' ${1}
