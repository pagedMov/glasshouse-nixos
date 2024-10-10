{ inputs, pkgs, ... }:

{
	imports = [ inputs.home-manager.nixosModules.home-manager ];
	home-manager = {
		useUserPackages = true;
		useGlobalPkgs = true;
		backupFileExtension = "backup";
		extraSpecialArgs = { inherit inputs; };
		users.pagedmov = {
			imports = [ ./../home ];
			home.username = "pagedmov";
			home.homeDirectory = "/home/pagedmov";
			home.stateVersion = "24.05";
			programs.home-manager.enable = true;
			pointerCursor = {
				name = "Quintom_Ink";
				size = 36;
				package = pkgs.quintom-cursor-theme;
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
