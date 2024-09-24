{
	description = "NixOS whole-scope system configuration flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		#glasshouse-desktop dots
		desktop-utils.url = "path:/home/pagedmov/sysflakes/glasshouse-desktop/dotfiles";
	};

	outputs = { nixpkgs, home-manager, desktop-utils, ... }@inputs: {
		nixosConfigurations = {
			glasshouse = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./glasshouse-desktop/configuration.nix
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.pagedmov = import ./glasshouse-desktop/home.nix;
						home-manager.extraSpecialArgs = {
						  desktop-utils = desktop-utils.packages."x86_64-linux".default;
						};
					}
				];

			};
		};
	};
}
