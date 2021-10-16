#! /bin/bash

LOGFILE=~/multimedia/keybindings.log

# For now I only care about switching to my emacs or terminal.
if [[ ! ${1} =~ emacs\@sp00ky|sp00kyTerminal ]]; then
    echo `date`": Invalid argument \$1=$1 to" ${BASH_SOURCE} >> ${LOGFILE}
    exit 1;
fi

# Emacs window on my PC is named emacs@sp00ky. We can just qualify on emacs since we can
# has some subprocesses spawned by jedi etc..
xdotool search --name ${1} \
        windowraise

# Hacky way to disable caps lock after enabling it. Ideally I'll be able to find a way
# to just disable the caps lock functionality and keep the key.
capsState=`xset q  | grep Caps | awk '{print $4 }'` # Query caps lock state with xset
if [[ ${capsState} == "on" ]]; then
    xdotool key --clearmodifiers Caps_Lock
fi

