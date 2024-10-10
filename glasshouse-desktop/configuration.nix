
{ config, lib, pkgs, inputs, ... }:

{
	system.stateVersion = "24.05"; 
	imports =
		[
		./hardware-configuration.nix
		];

## System - Environment ##

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking = {
		networkmanager.enable = true;  
		hostName = "glasshaus";
			hosts = {
				"192.168.1.163" = [ "glasshaus.info" ];
			};
		firewall = {
			enable = true;
			allowedTCPPorts = [ 30000 ];
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

## Programs - Services - Hardware ##

	programs = {
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
		openssh.enable = true;
		foundryvtt = {
			enable = false;
			hostName = "wumbodnd";
			package = inputs.foundryvtt.packages.${pkgs.system}.foundryvtt_12;
			minifyStaticFiles = true;
			proxyPort = 443;
			proxySSL = false;
			upnp = false;
		};
	};

	hardware = { 
		keyboard.uhk.enable = true;
		amdgpu.amdvlk.enable = true;
		bluetooth = {
			enable = true;
			powerOnBoot = true;
		};
	};

## Users - Packages ##
	
	security.sudo.extraConfig = ''
		pagedmov ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/nixos-rebuild
	'';
	users.users.pagedmov = {
		isNormalUser = true;
		shell = pkgs.zsh;
		extraGroups = [ "wheel" ]; 
	};

	nixpkgs.config.allowUnfree = true;

	fonts.packages = with pkgs; [ 
		times-newer-roman
		nerdfonts 
		jetbrains-mono 
	];
	environment.systemPackages = with pkgs; [
		# a
		alsa-lib
		alsa-utils
		# b
		bc
		# c
		cava
		clang
		clang-tools
		cmake
		# d
		# e
		# f
		fail2ban
		feh
		ffmpeg-full
		fuse
		fzf
		# g
		git
		gnumake
		gst_all_1.gstreamer
		# h
		htop
		hyprland
		hyprland-workspaces
		hyprpaper
		hyprpicker
		# i
		imagemagick
		inetutils
		# j
		# k
		kitty
		# l
		libclang
		libcxx
		lolcat
		lsof
		lua-language-server
		luarocks
		# m
		mesa
		mpd
		mullvad
		# n
		neofetch
		nix-index
		nix-prefetch-scripts
		nixos-option
		nix-search-cli
		# o
		openssl
		# p
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
		# q
		quintom-cursor-theme
		# r
		# s
		socat
		sox
		stress
		# t
		tor
		tree
		# u
		unrar
		unzip
		usbutils
		# v
		vim
		vim 
		vscode-langservers-extracted
		vulkan-loader
		# w
		wget
		wine
		wineWowPackages.full
		wl-clipboard
		# x
		xpad
		xwaylandvideobridge
		# y
		# z
	];



}

