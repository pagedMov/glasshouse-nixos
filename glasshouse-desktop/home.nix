{ config, pkgs, nvim, toilet, ... }:

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

# hi
# The home.packages option allows you to install Nix packages into your
# environment.
	home.packages = with pkgs; [
		hello
		waybar
		dunst
		rofi
		starship
		ranger
		zathura
		inkscape
		imagemagick
		firefox
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
		nvim
		toilet
	];

	home.pointerCursor = 
	let
		getFrom = url: hash: name: {
			gtk.enable = true;
			x11.enable = true;
			name = name;
			size = 24;
			package = pkgs.runCommand "moveUp" {} ''
				mkdir -p $out/share/icons
				ln -s ${pkgs.fetchzip {
					url = url;
					hash = hash;
					}} $out/share/icons/${name}
			'';
		};
	in
		getFrom 
			"https://gitlab.com/-/project/6703061/uploads/013137de48e6da3edc32bba068cf4c52/Hackneyed-Dark-24px-0.9.2-right-handed.tar.bz2"
			"sha256-fEAyeeEEknbGEGycmvMcU4M77x1InsQCuIBwcSasOcw="
			"Hackneyed-Dark";

	home.file = { # dotfiles
		# example
		# ".screenrc".source = dotfiles/screenrc;
		# ".gradle/gradle.properties".text = ''
		#   org.gradle.console=verbose
		#   org.gradle.daemon.idletimeout=3600000
		# ''
		".config/dunst/dunstrc".source = ./dotfiles/packages/dunst/dunstrc;
		".config/hypr/hyprland.conf".source = ./dotfiles/packages/hyprland/hyprland.conf;
		".config/hypr/hyprpaper.conf".source = ./dotfiles/packages/hyprland/hyprpaper.conf;
		".config/kitty/kitty.conf".source = ./dotfiles/packages/kitty/kitty.conf;
		".config/ranger/rc.conf".source = ./dotfiles/packages/ranger/rc.conf;
		".config/ranger/rifle.conf".source = ./dotfiles/packages/ranger/rifle.conf;
		".config/ranger/scope.sh".source = ./dotfiles/packages/ranger/scope.sh;
		".config/rofi/launcher.rasi".source = ./dotfiles/packages/rofi/launcher.rasi;
		".config/starship/starship.toml".source = ./dotfiles/packages/starship/starship.toml;
		".config/waybar/config".source = ./dotfiles/packages/waybar/config/config;
		".config/waybar/style.css".source = ./dotfiles/packages/waybar/config/style.css;

	};

# Let Home Manager install and manage itself.
	programs.zsh.enable = true;
	programs.home-manager.enable = true;
}
