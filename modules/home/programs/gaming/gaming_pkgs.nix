{ pkgs, ... }:

{
	home.packages = with pkgs; [
		snes9x-gtk
	];
}
