
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
		blueman.enable = true;
	};

	hardware = { 
		keyboard.uhk.enable = true;
		amdgpu.amdvlk.enable = true;
		bluetooth = {
			enable = true;
			powerOnBoot = true;
		};
	};
	
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
		alsa-lib
		alsa-utils
		bc
		cava
		clang
		clang-tools
		cmake
		fail2ban
		feh
		ffmpeg-full
		fuse
		fzf
		git
		gnumake
		gst_all_1.gstreamer
		htop
		hyprland
		hyprland-workspaces
		hyprpaper
		hyprpicker
		imagemagick
		inetutils
		kitty
		libclang
		libcxx
		lolcat
		lsof
		lua-language-server
		luarocks
		mesa
		mpd
		mullvad
		neofetch
		nix-index
		nix-prefetch-scripts
		nixos-option
		nix-search-cli
		openssl
		p7zip
		pamixer
		parted
		pass
		pavucontrol
		pkg-config
		playerctl
		protonmail-bridge
		protontricks
		pyright
		quintom-cursor-theme
		socat
		sox
		stress
		tor
		tree
		unrar
		unzip
		usbutils
		vim
		vim 
		vscode-langservers-extracted
		vulkan-loader
		wget
		wine
		wineWowPackages.full
		wl-clipboard
		xpad
		xwaylandvideobridge
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

