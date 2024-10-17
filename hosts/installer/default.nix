{ inputs, pkgs, modulesPath, ... }:

let
	nvim = inputs.nvim.packages."x86_64-linux".default;
	toilet = inputs.toilet.packages."x86_64-linux".default;
	install-script = pkgs.writeShellScriptBin "movcfg-install" ''
		#!/bin/bash
		set -e
		trap 'echo "Aborting installation."; exit 1' INT

		# set up working directory
		mkdir /tmp/install_pwd && cd /tmp/install_pwd

		# download disko.nix file for defining partitions
		echo "Downloading partition map... "
		curl https://raw.githubusercontent.com/vimjoyer/impermanent-setup/main/final/disko.nix > disko.nix

		lsblk
		echo
		echo "This script is about to format and partition a hard drive."
		sleep 1.5
		echo -e "\033[4;31mThis process is irreversible and will destroy all data on the drive.\033[0m"
		sleep 1.5
		echo "Make absolutely sure that you know which drive you are choosing. Abort with Ctrl+C if you aren't sure which one to use."
		sleep 1.5
		echo -n "Which drive do you wish to sacrifice? "
		read -r drive

		# commence formatting
		nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix --arg device "\"$drive\""

		# set up home directory in /mnt/persist, create /persist/etc/nixos, cd to /etc/nixos and install my flake config
		mkdir -p /mnt/persist/{etc/nixos,home}
		mkdir -p /mnt/etc
		cd /mnt/etc/
		rm -rf ./nixos
		git clone https://github.com/pagedMov/pagedmov-nix-cfg.git ./nixos

		nixos-install --root /mnt --flake /mnt/etc/nixos#oganesson

		echo "INSTALLATION COMPLETE \! \!" | toilet -f Slant | lolcat -a -s 60
		echo "You can reboot into your new system."


	'';
in
{
	imports = [
		"${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
		../../../modules/home/environment/zshell.nix
		../../../modules/home/environment/starship.nix
	];
	nixpkgs.hostPlatform = "x86_64-linux";
	system.stateVersion = "24.05";
	nix = {
		settings = {
			experimental-features = ["nix-command" "flakes"];
		};
	};

	users.users.root.shell = pkgs.zsh;
	users.users.nixos.shell = pkgs.zsh;


	networking = {
		wireless.enable = false;
		networkmanager.enable = true;
	};

	environment.systemPackages = with pkgs; [
		nvim
		lolcat
		curl
		wget
		zsh
		coreutils
		findutils
		zip
		unzip
		util-linux
		git
		btrfs-progs
		dosfstools
		parted
		pciutils
		usbutils
		toilet
		install-script
	];
	
	services = {
		openssh.enable = true; 
		dbus.enable=true;
	};
}
