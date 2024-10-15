{ self, pkgs, host}:


pkgs.writeShellScriptBin "nixcommit" (''
#!/run/current-system/sw/bin/bash

scheck && runbg aplay ${self}/media/sound/nixswitch-start.wav
builtin cd "$HOME/sysflakes" || exit
nix flake update

if [ -n "$2" ]; then
	echo "too many arguments"
	exit
fi

diffcheck=$(git status | grep "working tree clean")
if [ -n "$diffcheck" ]; then
	scheck && runbg aplay ${self}/media/sound/warning.wav
	echo "Nothing to commit"
	exit
fi

git add .

# Automatic fixup commit to the most recent commit (HEAD~1)
if [ -z "$1" ]; then
	commits=$(git log origin/$(git rev-parse --abbrev-ref HEAD)..HEAD --oneline)
	if [ -n "$commits" ]; then
		git commit --fixup HEAD
		echo "No commit message given"
		echo "Squashing into most recent commit"
		git rebase --autosquash master
	else
		echo "No prior local commits to squash into, please provide a commit message"
		exit
	fi
else
	# Generate the system generation number
	gen=$(readlink /nix/var/nix/profiles/system | sed 's/.*system-\([0-9]*\)-link/\1/')
	gen=$((gen + 1))
	git commit -m "(${host}) Gen $gen: $1"
fi

scheck && runbg aplay ${self}/media/sound/gitcommit.wav
builtin cd - || exit
	'')
