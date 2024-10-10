{ inputs, pkgs, ... }:

{
	imports = [ inputs.home-manager.nixosModules.home-manager ];
	home-manager = {
		useUserPackages = true;
		useGlobalPkgs = true;
		backupFileExtension = "backup";
		extraSpecialArgs = { inherit inputs; };
		users.pagedmov = {
			programs.home-manager.enable = true;
			imports = [ ./../home ];
			home = {
				username = "pagedmov";
				homeDirectory = "/home/pagedmov";
				stateVersion = "24.05";
				pointerCursor = {
					name = "Quintom_Ink";
					size = 36;
					package = pkgs.quintom-cursor-theme;
				};
			};
		};
	};
	users.users.pagedmov = {
		isNormalUser = true;
		shell = pkgs.zsh;
		extraGroups = [ "wheel" ]; 
	};
	security.sudo.extraConfig = ''
		pagedmov ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/nixos-rebuild
	'';
	nix.settings.allowed-users = [ "pagedmov" ];
}
