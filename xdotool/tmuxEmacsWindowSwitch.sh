#! /bin/bash

# TODO:
# Check if we are in emacs or tmux before sending keys
LOGFILE=~/multimedia/keybindings.log

# If our first argument is not a single digit then exit.
if [[ ! ${1} =~ ^[0-9]$ ]]; then
    echo `date`": Invalid argument \$1=$1 to" ${BASH_SOURCE} >> ${LOGFILE}
    exit 1;
fi


xdotool sleep 0.2 key ctrl+a $1
