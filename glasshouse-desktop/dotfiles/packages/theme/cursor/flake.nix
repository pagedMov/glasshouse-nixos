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
				default = pkgs.stdenv.mkDerivation {
					pname = "hackneyed-cursors";
					version = "0.9.2";

					src = pkgs.fetchFromGitHub {
						owner = "Enthymeme";
						repo = "hackneyed-x11-cursors";
						rev = "master";
						sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAA=";
					};

					buildInputs = with pkgs; [
						imagemagick
						inkscape
						make
						bash
						xorg.xcursorgen
					];

					buildPhase = ''
						./build-all-themes.sh --dark-theme-only -j dist.large
					'';
				};
			};
		};
}
