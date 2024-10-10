#!/bin/bash

TERMCOUNTER="/tmp/termcounter_$(whoami)"
if [[ ! -f "$TERMCOUNTER" ]]; then
	echo 0 > "$TERMCOUNTER"
fi
UPDATES="/tmp/numupdates"
[ ! -e "$UPDATES" ] && UPDATES="0" # if it does not, UPDATES is equal to zero
[ -e "$UPDATES" ] && UPDATES=$(cat "$UPDATES") # if updates file exists, record number of updates


TERMINAL_COUNT=$(cat "$TERMCOUNTER")
TERMINAL_COUNT=$((TERMINAL_COUNT+1))

CMD_COUNT=$(cat "/tmp/cmdcounter_$(whoami)")
echo "$TERMINAL_COUNT" > "$TERMCOUNTER"

echo "NixOS kernel ver. $(uname -a | awk '{print $3}') x86_64 GNU/Linux"
date +"%A %B %-d %Y"
echo -e "\033[38;2;0;180;205m$(toilet -t -f Slant.flf glasshouse)\033[0m"
echo -e "\033[38;2;0;180;205mTerminals Opened This Session:\033[0m $TERMINAL_COUNT"
echo -e "\033[38;2;0;180;205mCommands Entered This Session:\033[0m $CMD_COUNT"
