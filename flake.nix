{
	description = "pagedMov's NixOS configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		hypr-contrib.url = "github:hyprwm/contrib";
		hyprpicker.url = "github:hyprwm/hyprpicker";
		hyprland = {
		  type = "git";
		  url = "https://github.com/hyprwm/Hyprland";
		  submodules = true;
		};

		catppuccin-bat = {
			url = "github:catppuccin/bat";
			flake = false;
		};
		catppuccin-cava = {
			url = "github:catppuccin/cava";
			flake = false;
		};
		catppuccin-starship = {
			url = "github:catppuccin/starship";
			flake = false;
		};
		catppuccin-yazi = {
			url = "github:catppuccin/yazi";
			flake = false;
		};
		spicetify-nix = {
			url = "github:gerg-l/spicetify-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		agenix.url = "github:ryantm/agenix";

		#glasshouse-desktop dots
		nvim.url = "path:/home/pagedmov/sysflakes/glasshouse-desktop/home/nixvim";
		toilet.url = "path:/home/pagedmov/sysflakes/glasshouse-desktop/home/toilet";
	};

	outputs = { nixpkgs, home-manager, self, agenix, nvim, toilet, ... }@inputs: 
	let
		system = "x86_64-linux";
        username = "pagedmov";
		allowed-unfree-packages = [
             "foundryvtt"
           ];
	in
	{
		nixosConfigurations = {
			glasshouse = nixpkgs.lib.nixosSystem {
				specialArgs = { 
					inherit self inputs allowed-unfree-packages username;
				};
				inherit system;
				modules = [ 
					./glasshouse-desktop/sys 
					agenix.nixosModules.default 
				];
			};
		};
	};
}
