{ pkgs }:

{
	toggle_float = pkgs.writeShellScriptBin "toggle_float" (''
#!/usr/bin/env bash

hyprctl dispatch togglefloating
hyprctl dispatch resizeactive exact 950 600
hyprctl dispatch centerwindow
	'');
}
