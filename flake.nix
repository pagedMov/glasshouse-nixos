{
	description = "NixOS whole-scope system configuration flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		#glasshouse-desktop dots
		nvim.url = "path:/home/pagedmov/sysflakes/glasshouse-desktop/dotfiles/packages/nixvim";
		nix-autobahn.url = "path:/home/pagedmov/sysflakes/glasshouse-desktop/derivations/nix-autobahn";
		toilet.url = "path:/home/pagedmov/sysflakes/glasshouse-desktop/dotfiles/packages/toilet";
		foundryvtt.url = "github:reckenrode/nix-foundryvtt";
		rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
	};

	outputs = { nixpkgs, rose-pine-hyprcursor, home-manager, foundryvtt, nvim, toilet, nix-autobahn, ... }@inputs: 
	let
		system = "x86_64-linux";
        user = "pagedmov";
		allowed-unfree-packages = [
             "foundryvtt"
           ];
	in
	{
		nixosConfigurations = {
			glasshouse = nixpkgs.lib.nixosSystem {
				specialArgs = { 
					inherit inputs;
					inherit allowed-unfree-packages user; 
				};
				inherit system;
				modules = [
					./glasshouse-desktop/configuration.nix
					home-manager.nixosModules.home-manager
					foundryvtt.nixosModules.foundryvtt
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.${user} = import ./glasshouse-desktop/home.nix;
						home-manager.extraSpecialArgs = {
							inherit allowed-unfree-packages user;
							nvim = nvim.packages."x86_64-linux".default;
							toilet = toilet.packages."x86_64-linux".default;
							nix-autobahn = nix-autobahn.packages."x86_64-linux".nix-autobahn;
						};
					}
				];
				specialArgs = {
				};
			};
			environment.systemPackages = with nixpkgs; environment.systemPackages ++ [
				rose-pine-hyprcursor.packages."x86_64-linux".default
			];
		};
	};
}
