#!/bin/bash

echo "NixOS kernel ver. $(uname -a | awk '{print $3}') x86_64 GNU/Linux"
date +"%A %B %-d %Y"
echo -e "\033[38;2;0;180;205m$(toilet -t -f Slant.flf glasshouse)\033[0m"
echo -e "\033[38;2;0;180;205mTerminals Opened This Session:\033[0m $TERMINAL_COUNT"
echo -e "\033[38;2;0;180;205mCommands Entered This Session:\033[0m $CMD_COUNT"
echo
