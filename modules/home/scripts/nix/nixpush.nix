{ self, pkgs }:


pkgs.writeShellScriptBin "nixpush" (''
#!/run/current-system/sw/bin/bash

scheck && runbg aplay ${self}/media/sound/nixswitch-start.wav
set -e
pushd "$HOME/sysflakes"

commits=$(git log origin/$(git rev-parse --abbrev-ref HEAD)..HEAD --oneline)
if [ -z "$commits" ]; then
	scheck && runbg aplay ${self}/media/sound/warning.wav
	echo "Nothing to push"
	exit
fi

echo "Pushing the following commits upstream on branch '$(git branch | rg "\*" | awk '{print $2}')'"
echo "$commits"

git push
scheck && runbg aplay ${self}/media/sound/gitpush.wav
popd
	'')
