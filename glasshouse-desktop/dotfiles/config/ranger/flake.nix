{
	description = "Flake Boilerplate";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs, ... }@inputs:
		let
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
		in {
			packages.${system} = {
				default = pkgs.ranger.overrideAttrs (oldAttrs: {
					configFile = ./rc.conf;
				});

			};
		};
}
