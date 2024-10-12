#!/run/current-system/sw/bin/bash

scheck && runbg aplay ~/media/sound/sys/nixswitch-start.wav
builtin cd "$HOME/sysflakes" || exit
nix flake update

gen=$(readlink /nix/var/nix/profiles/system | sed 's/.*system-\([0-9]*\)-link/\1/')
gen=$((gen + 1))

git add .
git commit -m "Gen $gen: $@"
git push
scheck && runbg aplay ~/media/sound/sys/gitpush.wav
builtin cd - || exit
