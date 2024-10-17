{
  self,
  pkgs,
}:
pkgs.writeShellScriptBin "homep" ''
  #!/run/current-system/sw/bin/bash

  # Ensure the package manifest is generated or updated
  if [ ! -f "/tmp/nixpkgs_manifest.txt" ]; then
      echo "Generating Nixpkgs manifest..."
      nix-env -qaP 2>/dev/null | awk '{print $1}' | sed 's/nixos\.//' > /tmp/nixpkgs_manifest.txt
  fi

  # Select packages using fzf with multi-select enabled
  selected_packages=$(cat /tmp/nixpkgs_manifest.txt | fzf -m)

  # Check if any packages were selected
  if [ -n "$selected_packages" ]; then
      echo "$selected_packages" | while read -r package; do
          # Append each selected package to the Nix config file
          sed -i "/^\t]/i \ \t\t$package" "${self}/modules/home/userpkgs.nix"
          echo "Added $package to the Home Manager configuration."
      done

  	echo "Packages added successfully. Rebuild system config?"
  	select yn in "Yes" "No"; do
  		case $yn in
  			"Yes" ) nixswitch;break;;
  			"No" ) exit;;
  		esac
  	done

  else
      echo "No packages selected."
  fi
''
