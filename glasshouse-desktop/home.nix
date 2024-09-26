{ config, pkgs, nvim, toilet, ... }:

{
# Home Manager needs a bit of information about you and the paths it should
# manage.
	imports = [ ./modules/zshell.nix ];

	home = { 
		stateVersion = "24.05"; # Please read the comment before changing.
		username = "pagedmov";
		homeDirectory = "/home/pagedmov";
		enableNixpkgsReleaseCheck = false;
		sessionVariables = {
			GTK_THEME = "Adwaita:dark";
		};


# This value determines the Home Manager release that your configuration is
# compatible with. This helps avoid breakage when a new Home Manager release
# introduces backwards incompatible changes.
#
# You should not change this value, even if you update Home Manager. If you do
# want to update the value, then make sure to first check the Home Manager
# release notes.

# hi
# The home.packages option allows you to install Nix packages into your
# environment.
		packages = with pkgs; [
			hello
			nerdfonts
			grimblast
			gtk3
			adwaita-icon-theme
			waybar
			uhk-agent
			dunst
			rofi
			cargo
			sqlite
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

		pointerCursor = {
			name = "Quintom_Ink";
			size = 36;
			package = pkgs.quintom-cursor-theme;
		};

			file = { # dotfiles
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
				".zstyle".source = ./dotfiles/zsh-style;
			};
		};

# Let Home Manager install and manage itself.
	programs = { 
		zsh.enable = true;
		home-manager.enable = true;
	};
}
