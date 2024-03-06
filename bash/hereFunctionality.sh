#!/bin/bash

#   Here Documents
#       This type of redirection instructs the shell to read input
#       from the current source until a line containing only delimiter
#       (with no trailing blanks) is seen.  All of the lines read up
#       to that point are then used as the standard input for a
#       command.
#
#       The format of here-documents is:
#
#              <<[-]word
#                      here-document
#              delimiter
#
#       No parameter expansion, command substitution, arithmetic
#       expansion, or pathname expansion is performed on word.  If any
#       characters in word are quoted, the delimiter is the result of
#       quote removal on word, and the lines in the here-document are
#       not expanded.  If word is unquoted, all lines of the
#       here-document are subjected to parameter expansion, command
#       substitution, and arithmetic expansion.  In the latter case,
#       the character sequence \<newline> is ignored, and \ must be
#       used to quote the characters \, $, and `.
#
#       If the redirection operator is <<-, then all leading tab
#       characters are stripped from input lines and the line
#       containing delimiter.  This allows here-documents within shell
#       scripts to be indented in a natural fashion.

cat << END
This is me using a here document
Here is another line

There was a blank one
END


#
#   Here Strings
#       A variant of here documents, the format is:
#
#              <<<word
#
#       The word is expanded and supplied to the command on its
#       standard input.
cat <<< "Here is me using a here string
It can have newlines."

# W
tmp="This is me using a variable value "
cat <<< ${tmp}
