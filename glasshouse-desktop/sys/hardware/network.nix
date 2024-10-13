{ pkgs, ... }:

{
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
}
