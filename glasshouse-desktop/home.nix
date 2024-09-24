{ config, pkgs, desktop-utils, ... }:

{
# Home Manager needs a bit of information about you and the paths it should
# manage.
	home.username = "pagedmov";
	home.homeDirectory = "/home/pagedmov";
	home.enableNixpkgsReleaseCheck = false;

	imports = [ ./modules/zshell.nix ];

# This value determines the Home Manager release that your configuration is
# compatible with. This helps avoid breakage when a new Home Manager release
# introduces backwards incompatible changes.
#
# You should not change this value, even if you update Home Manager. If you do
# want to update the value, then make sure to first check the Home Manager
# release notes.
	home.stateVersion = "24.05"; # Please read the comment before changing.


# The home.packages option allows you to install Nix packages into your
# environment.
	home.packages = with pkgs; [
		hello
		waybar
		dunst
		rofi
		starship
		ranger
		firefox
		zathura
		yt-dlp
		vlc
		spotify
		speedtest-cli
		vesktop
		qbittorrent
		obs-studio
		neovide
		chromium
		zsh
		zsh-syntax-highlighting
		zsh-history-substring-search
		zsh-autosuggestions
		desktop-utils
	];

	home.file = { # dotfiles
		# example
		# ".screenrc".source = dotfiles/screenrc;
		# ".gradle/gradle.properties".text = ''
		#   org.gradle.console=verbose
		#   org.gradle.daemon.idletimeout=3600000
		# ''


	};

# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
