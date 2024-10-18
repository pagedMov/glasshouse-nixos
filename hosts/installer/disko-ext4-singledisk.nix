# USAGE in your configuration.nix.
# Update devices to match your hardware.
{
	device ? throw "Set this to your disk device, e.g. /dev/sda",
				 ...
}:

{
	disko.devices = {
		disk = {
			main = {
				inherit device;
				type = "disk";
				content = {
					type = "gpt";
					partitions = {
						boot = {
							size = "1M";
							type = "EF02"; # for grub MBR
						};
						ESP = {
							size = "1G";
							type = "EF00";
							content = {
								type = "filesystem";
								format = "vfat";
								mountpoint = "/boot";
								mountOptions = [ "umask=0077" ];
							};
						};
						nix = {
							size = "35%";
							content = {
								type = "filesystem";
								format = "ext4";
								mountpoint = "/home";
							};
						};
						root = {
							size = "15%";
							content = {
								type = "filesystem";
								format = "ext4";
								mountpoint = "/";
							};
						};
						home = {
							size = "50% - 500MB";
							content = {
								type = "filesystem";
								format = "ext4";
								mountpoint = "/home";
							};
						};
					};
				};
			};
		};
	};
}
