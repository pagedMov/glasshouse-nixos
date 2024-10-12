{ pkgs }:

{
	s_check = pkgs.writeShellScriptBin "s_check" (''
#!/run/current-system/sw/bin/bash

[ "$SOUNDS_ENABLED" -eq 1 ]
	'');
}
