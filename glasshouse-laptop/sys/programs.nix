{ pkgs, ... }:

{
	programs = {
		steam.enable = true;
		hyprland.enable = true;
		zsh.enable = true;
		nix-ld = {
			enable = true;
			libraries = with pkgs; [
				stdenv.cc.cc
				ffmpeg-full
			];
		};
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
		};
	};
}
