#!/run/current-system/sw/bin/bash

scheck && runbg aplay ~/media/sound/sys/nixswitch-start.wav
builtin cd "$HOME/sysflakes" || exit

nix flake update
sudo nixos-rebuild switch --flake "$HOME/sysflakes#glasshouse-laptop"
if [ $? -eq 0 ]; then 
	scheck && runbg aplay ~/media/sound/sys/update.wav
else
	scheck && runbg aplay ~/media/sound/sys/error.wav
fi
builtin cd "$OLDPWD" || exit
