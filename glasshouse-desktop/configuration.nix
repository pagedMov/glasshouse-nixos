
{ config, lib, pkgs, ... }:

{
	imports =
		[
		./hardware-configuration.nix
		];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking = {
		networkmanager.enable = true;  # Easiest to use and most distros use this by default.
		hostName = "glasshouse";
			hosts = {
				"192.168.1.163" = [ "glasshouse.info" ];
			};
	};

	programs.nix-ld = {
		enable = true;
		libraries = with pkgs; [
			stdenv.cc.cc
		];
	};

	environment.variables = {
		XCURSOR_SIZE = "24";
		PATH = "${pkgs.clang-tools}/bin:$PATH";
	};


	time.timeZone = "America/New_York";
	i18n.defaultLocale = "en_US.UTF-8";

	programs.hyprland.enable = true;
	programs.steam.enable = true;
	home-manager.backupFileExtension = "backup";

# Enable sound.
	#hardware.pulseaudio.enable = true;
# OR
	services.pipewire = {
		enable = true;
		pulse.enable = true;
		wireplumber.enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
	};
	services.udev.enable = true;
	services.dbus.enable = true;
	security.sudo.extraConfig = ''
pagedmov ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/nixos-rebuild
	'';


	users.users.pagedmov = {
		isNormalUser = true;
		extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
	};

	nixpkgs.config.allowUnfree = true;
	fonts.packages = with pkgs; [ nerdfonts jetbrains-mono ];
	environment.systemPackages = with pkgs; [
		parted
		vim 
		pass
		gnumake
		wget
		alsa-utils
		alsa-lib
		zsh
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
		playerctl
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
		clang-tools
		libclang
		cava
		quintom-cursor-theme
	];


# List services that you want to enable:

# Enable the OpenSSH daemon.
	services.openssh.enable = true;
	programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
	};

	system.stateVersion = "24.05"; # Did you read the comment?

}

