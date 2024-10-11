#!/run/current-system/sw/bin/bash

scheck && (aplay ~/sound/sys/nixswitch-start.wav > /dev/null 2>&1 &)
builtin cd "$HOME/sysflakes" || exit
nix flake update

gen=$(readlink /nix/var/nix/profiles/system | sed 's/.*system-\([0-9]*\)-link/\1/')
gen=$((gen + 1))

git diff --quiet
if mycmd; then
	echo "Nothing to commit"
	return
fi
git add .
git commit -m "Gen $gen: $@"
git push
builtin cd - || exit
