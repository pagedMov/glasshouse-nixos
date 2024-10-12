{ self, pkgs }:

{
	switchmon = pkgs.writeShellScriptBin "switchmon" (''
#!/bin/zsh

hyprctl dispatch focusmonitor $(echo "$(hyprctl -j monitors)" | jq -r '.[] | select(.focused == false) | .name')
	'');
}
