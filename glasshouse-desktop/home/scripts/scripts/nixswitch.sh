#!/run/current-system/sw/bin/bash

s_check && (aplay ~/sound/sys/nixswitch-start.wav > /dev/null 2>&1 &)
builtin cd "$HOME/sysflakes" || exit

nix flake update
sudo nixos-rebuild switch --flake "$HOME/sysflakes#glasshouse"
if mycmd; then 
	s_check && (aplay ~/sound/sys/update.wav > /dev/null 2>&1 &)
else
	s_check && (aplay ~/sound/sys/error.wav > /dev/null 2>&1 &)
fi
builtin cd "$OLDPWD" || exit
