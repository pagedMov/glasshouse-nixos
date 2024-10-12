{ self, pkgs }:

{
	homer = pkgs.writeShellScriptBin "homer" (''
#!/run/current-system/sw/bin/bash

selected_packages=$(sed -n '/\[/,/\]/p' "$HOME/sysflakes/glasshouse-desktop/home/userpkgs.nix" | sed '1d;$d' | fzf -m)

if [ -n "$selected_packages" ]; then
	echo "$selected_packages" | while read -r package; do
		sed -i "/\b$package\b/d" "$HOME/sysflakes/glasshouse-desktop/home/userpkgs.nix"
		echo "Removed $package from the Home Manager configuration."
	done

	echo "Removed packages. Rebuild system config?"
	select yn in "Yes" "No"; do
		case $yn in
			"Yes" ) nixswitch;break;;
			"No" ) exit;;
		esac
	done

else
	echo "No packages removed."
fi



	'');
}
