#! /bin/bash

LOGFILE=/multimedia/keybindings.log
arg=${1}

# If our first argument is not a single digit then exit.
if [[ ! ${1} =~ ^[0-9]$ ]]; then
   echo `date`": Invalid argument \$1=$1 to" ${BASH_SOURCE} >> ${LOGFILE}
   exit 1;
fi

windowName=`xdotool getwindowfocus getwindowname`
if [[ $windowName =~ emacs\@sp00ky|Sp00kyTerminal ]]; then
   xdotool sleep 0.2 key ctrl+a $1
else
   # This is recursive... find a way to make it not recursive. Right
   # now, I am just killing xbindkeys and restarting it... this is
   # rather crass...

   # kill -9 `pidof xbindkeys`
   # xdotool key F$((arg + 3))
   # xbindkeys

   # Seems like sending the key to the specified window fixes the
   # issue. But, according to the man page, some apps may not
   # recognize these key presses. For these apps I'll have to do
   # something like above where I kill xbindkeys.
   xdotool getwindowfocus key --window %1 F$((arg + 3))
fi

