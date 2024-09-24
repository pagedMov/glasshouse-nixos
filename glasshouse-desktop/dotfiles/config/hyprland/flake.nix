{
	description = "Hyprland Package Suite";

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
				name = "hyprland-suite";
				src = pkgs.hyprland.src;

				buildInputs = [
					pkgs.hyprpaper
					pkgs.hyprland-workspaces
					pkgs.hyprpicker
					pkgs.xdg-desktop-portal
					pkgs.xdg-desktop-portal-hyprland
				];

				installPhase = ''
					make install PREFIX=$out
				'';

				meta = with pkgs.lib; {
					description = "A package containing hyprland along with some utilities that were made for it";
					license = licenses.mit;
					maintainers = with maintainers; [ pagedMov ];
					platforms = platforms.linux;


				};
			};
		};
		devShells.${system} = pkgs.mkShell {
			buildInputs = [
					pkgs.hyprpaper
					pkgs.hyprland-workspaces
					pkgs.hyprpicker
					pkgs.xdg-desktop-portal
					pkgs.xdg-desktop-portal-hyprland
			];
			shellHook = ''
				echo "testing hyprland suite"
			'';
		};
	};
}
