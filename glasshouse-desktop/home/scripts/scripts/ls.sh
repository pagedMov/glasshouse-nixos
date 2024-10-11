#!/run/current-system/sw/bin/bash

eza -1 --group-directories-first --icons "$@"
s_check && runbg aplay ~/sound/sys/ls.wav
