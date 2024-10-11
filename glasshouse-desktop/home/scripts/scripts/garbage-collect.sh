#!/run/current-system/sw/bin/bash


echo "This will delete all unused paths in the nix store and delete any files in the gtrash folder."
echo "\033[1;4;38;2;230;69;83mThis process is irreversible.\033[0m Are you sure?"
select yn in "Yes" "No"; do
	case $yn in
		Yes ) echo "Sweeping system...";break;;
		No ) echo "Canceling garbage collection."; return;;
	esac
done
output=$(nix-collect-garbage | tee /dev/tty)

nix_freed=$(echo "$output" | grep -oP '\d+(\.\d+)? MiB freed' | cut -d' ' -f1)
rm_freed=$(du ~/.local/share/Trash/files/* ~/steamlib/.Trash-1000/files/* 2> /dev/null | awk '{sum += $1} END {print sum}')
rm_freed=$(echo "scale=2; $rm_freed / 1000" | bc)
/run/current-system/sw/bin/rm -rfv ~/.local/share/Trash/files/*
/run/current-system/sw/bin/rm -rfv ~/steamlib/.Trash-1000/files/*
total_freed=$(echo "$nix_freed + $rm_freed" | bc)
echo "System cleaning complete, freed $total_freed MiB in total"
