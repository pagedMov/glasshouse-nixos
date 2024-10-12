{ pkgs, inputs, ... }:
let
	nvim = inputs.nvim.packages."x86_64-linux".default;
	toilet = inputs.toilet.packages."x86_64-linux".default;
in
{
	home.packages = with pkgs; [
		hello
		gtk3
		adwaita-icon-theme
		dunst
		sqlite
		starship
		zathura
		imagemagick
		firefox
		yt-dlp
		vlc
		speedtest-cli
		vesktop
		qbittorrent
		obs-studio
		neovide
		zsh
		zsh-syntax-highlighting
		zsh-history-substring-search
		zsh-autosuggestions
		snes9x-gtk
		rustup
		libreoffice
		handbrake
		gtrash
		ripgrep
		nvim
		toilet
	];
}
