{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixvim = {
			url = "path:packages/nixvim";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		toilet = {
			url = "path:packages/toilet";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		hackneyed-cursors = {
			url = "path:packages/theme/cursor";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, nixvim, hackneyed-cursors, toilet, ... }@inputs:
		let
		system = "x86_64-linux";
	pkgs = nixpkgs.legacyPackages.${system};
	in {
# Consolidating packages into a single one
		packages.${system} = {
			default = pkgs.stdenv.mkDerivation {
				name = "desktop-env-tools";
				src = ./.;

				buildInputs = [
					nixvim.packages.${system}.default
						toilet.packages.${system}.default
				];

				installPhase = ''
					mkdir -p $out/bin
					ln -s ${nixvim.packages.${system}.default}/bin/nvim $out/bin/nvim
					ln -s ${toilet.packages.${system}.default}/bin/toilet $out/bin/toilet
					ln -s ${hackneyed-cursors.packages.${system}.default} $out/bin/toilet
					'';
			};
		};
	};
}
