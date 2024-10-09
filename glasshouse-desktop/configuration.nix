
{ config, lib, pkgs, inputs, ... }:

{
	imports =
		[
		./hardware-configuration.nix
		];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking = {
		networkmanager.enable = true;  # Easiest to use and most distros use this by default.
		hostName = "glasshaus";
			hosts = {
				"192.168.1.163" = [ "glasshaus.info" ];
			};
		firewall = {
			enable = true;
			allowedTCPPorts = [ 30000 ];
		};
	};

	programs = {
		zsh.enable = true;
		nix-ld = {
			enable = true;
			libraries = with pkgs; [
				stdenv.cc.cc
				ffmpeg-full
			];
		};
	};

	environment = {
		variables = {
			XCURSOR_SIZE = "24";
			PATH = "${pkgs.clang-tools}/bin:$PATH";
		};
		shells = with pkgs; [
			zsh
			bash
		];
	};


	time.timeZone = "America/New_York";
	i18n.defaultLocale = "en_US.UTF-8";

	programs.hyprland.enable = true;
	programs.steam.enable = true;
	home-manager.backupFileExtension = "backup";

# Enable sound.
	#hardware.pulseaudio.enable = true;
# OR

	services = {
		pipewire = {
				enable = true;
				pulse.enable = true;
				wireplumber.enable = true;
				alsa.enable = true;
				alsa.support32Bit = true;
			};
		udev.enable = true;
		dbus.enable = true;
		mullvad-vpn.enable = true;
	};

	hardware.keyboard.uhk.enable = true;
	hardware.amdgpu.amdvlk.enable = true;
	security.sudo.extraConfig = ''
pagedmov ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/nixos-rebuild
	'';
	users.users.pagedmov = {
		isNormalUser = true;
		shell = pkgs.zsh;
		extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
	};

	nixpkgs.config.allowUnfree = true;
	fonts.packages = with pkgs; [ times-newer-roman nerdfonts jetbrains-mono ];
	environment.systemPackages = with pkgs; [
		parted
		mullvad
		fuse
		wineWowPackages.full
		vulkan-loader
		mesa
		vim 
		pass
		gnumake
		wget
		alsa-utils
		alsa-lib
		git
		kitty
		xwaylandvideobridge
		xpad
		wl-clipboard
		wine
		vscode-langservers-extracted
		vim
		usbutils
		unzip
		unrar
		tor
		stress
		sox
		socat
		pyright
		protontricks
		protonmail-bridge
		nix-index
		playerctl
		tree
		pavucontrol
		pamixer
		p7zip
		neofetch
		luarocks
		lua-language-server
		lsof
		lolcat
		imagemagick
		hyprpicker
		hyprpaper
		hyprland-workspaces
		hyprland
		htop
		mpd
		inetutils
		fzf
		feh
		fail2ban
		cmake
		clang
		ffmpeg-full
		pkg-config
		openssl
		libcxx
		gst_all_1.gstreamer
		bc
		clang-tools
		libclang
		cava
		quintom-cursor-theme
		nixos-option
	];


# List services that you want to enable:

# Enable the OpenSSH daemon.
	services.openssh.enable = true;
	programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
	};
	services.foundryvtt = {
		enable = true;
		hostName = "wumbodnd";
		package = inputs.foundryvtt.packages.${pkgs.system}.foundryvtt_12;
		minifyStaticFiles = true;
		proxyPort = 443;
		proxySSL = false;
		upnp = false;
	};

	system.stateVersion = "24.05"; # Did you read the comment?

}

