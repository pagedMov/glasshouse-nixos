#!/run/current-system/sw/bin/bash

export SOUNDS_ENABLED=0
eza -1 --group-directories-first --icons "$@"
builtin cd "$@" || exit
export SOUNDS_ENABLED=1
s_check && (aplay ~/sound/sys/cd.wav > /dev/null 2>&1 &)
