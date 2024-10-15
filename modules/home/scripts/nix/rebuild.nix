{ host, self, pkgs }:


pkgs.writeShellScriptBin "rebuild" (''
#!/run/current-system/sw/bin/bash

scheck && runbg aplay ${self}/media/sound/nixswitch-start.wav
set -e
pushd "$HOME/sysflakes"

nix flake update
git diff
sudo nixos-rebuild switch --flake "$HOME/sysflakes#${host}"
if [ $? -eq 0 ]; then 
	scheck && runbg aplay ${self}/media/sound/update.wav
else
	scheck && runbg aplay ${self}/media/sound/error.wav
fi
popd
'')
