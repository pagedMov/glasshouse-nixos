{ config, inputs, pkgs, username, self, host, ... }:

let
	nur = config.nur;
in
{
	imports = [ inputs.home-manager.nixosModules.home-manager ];
	home-manager = {
		useUserPackages = true;
		useGlobalPkgs = true;
		backupFileExtension = "backup";
		extraSpecialArgs = { inherit self inputs host username nur; };
		users.${username} = {
			programs.home-manager.enable = true;
			imports = 
				if (host == "desktop") then 
					[ ./../../home/desktop.nix ]
				else [./../../home/laptop.nix ];
			home = {
				username = "${username}";
				homeDirectory = "/home/${username}";
				stateVersion = "24.05";
				pointerCursor = {
					name = "Quintom_Ink";
					size = 36;
					package = pkgs.quintom-cursor-theme;
				};
			};
		};
	};
	users.users.${username} = {
		isNormalUser = true;
		shell = pkgs.zsh;
		extraGroups = [ "wheel" ]; 
	};
	security.sudo.extraConfig = ''
		${username} ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/nixos-rebuild
	'';
	nix.settings.allowed-users = [ "${username}" ];
}
