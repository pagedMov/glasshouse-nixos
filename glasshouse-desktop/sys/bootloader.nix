{ pkgs, ... }:

{
	boot = {
		loader.systemd-boot.enable = true;
		loader.efi.canTouchEfiVariables = true;
		loader.systemd-boot.configurationLimit = 10;
		boot.kernelPackages = pkgs.linuxPackages_latest;
	};
}
