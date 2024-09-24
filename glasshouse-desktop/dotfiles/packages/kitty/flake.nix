{
	description = "Kitty Configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs, ... }@inputs:
		let
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
		in {
			packages.${system} = {
				default = pkgs.kitty.overrideAttrs (oldAttrs: {
					configFile = ./kitty.conf;
				});
			};
		

		devShells.default = pkgs.mkShell {
			buildInputs = [ pkgs.kitty ];
		};
	};
}
