{
	description = "NixOS whole-scope system configuration flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		#glasshouse-desktop dots
		nvim.url = "path:/home/pagedmov/sysflakes/glasshouse-desktop/dotfiles/packages/nixvim";
		toilet.url = "path:/home/pagedmov/sysflakes/glasshouse-desktop/dotfiles/packages/toilet";
		rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
	};

	outputs = { nixpkgs, rose-pine-hyprcursor, home-manager, nvim, toilet, ... }@inputs: {
		nixosConfigurations = {
			glasshouse = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs; };
				system = "x86_64-linux";
				modules = [
					./glasshouse-desktop/configuration.nix
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.pagedmov = import ./glasshouse-desktop/home.nix;
						home-manager.extraSpecialArgs = {
						  nvim = nvim.packages."x86_64-linux".default;
						  toilet = toilet.packages."x86_64-linux".default;
						};
					}
				];
			};
			environment.systemPackages = with nixpkgs; environment.systemPackages ++ [
				rose-pine-hyprcursor.packages."x86_64-linux".default
			];
		};
	};
}
