{
  self,
  pkgs,
}:
pkgs.writeShellScriptBin "nixr" ''
  #!/run/current-system/sw/bin/bash

  selected_packages=$(sed -n '/\[/,/\]/p' "$HOME/sysflakes/glasshouse-desktop/sys/packages.nix" | sed '1d;$d' | fzf -m)

  if [ -n "$selected_packages" ]; then
  	echo "$selected_packages" | while read -r package; do
  		sed -i "/\b$package\b/d" "$HOME/sysflakes/glasshouse-desktop/sys/packages.nix"
  		echo "Removed $package from the Nix configuration."
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



''
