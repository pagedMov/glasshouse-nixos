{ self, pkgs }:


pkgs.writeShellScriptBin "mcd" (''
#!/run/current-system/sw/bin/bash


mkdir -p "$1"
cd "$1" || exit
	'')
