{
	description = "Hackneyed X11 Cursors";

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
					pname = "hackneyed-cursors-dark-right-48px";
					version = "0.9.2";

					src = pkgs.fetchurl {
						url = "https://gitlab.com/-/project/6703061/uploads/53e6cb854a0bd446b326ca7c40fb5cdf/Hackneyed-Dark-48px-0.9.2-right-handed.tar.bz2";
						sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAA=";
					};

					installPhase = ''
						mkdir -p $out/share/icons/Hackneyed-Dark
						tar xjf $src -C $out/share/icons/Hackneyed-Dark --strip-components=1
					'';
				};
			};
		};
}
