{ self, pkgs }:


pkgs.writeShellScriptBin "nixswitch" (''
#!/run/current-system/sw/bin/bash

scheck && runbg aplay ${self}/media/sound/nixswitch-start.wav
builtin cd "$HOME/sysflakes" || exit

nix flake update
sudo nixos-rebuild switch --flake "$HOME/sysflakes#glasshouse-desktop"
if [ $? -eq 0 ]; then 
	scheck && runbg aplay ${self}/media/sound/update.wav
else
	scheck && runbg aplay ${self}/media/sound/error.wav
fi
builtin cd "$OLDPWD" || exit
	'')
