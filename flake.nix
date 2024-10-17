{
  description = "pagedMov's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
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

		nvim = {
			url = "github:pagedMov/pagedmov-nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
		};

    #glasshouse-desktop dots
    toilet = {
			url = "github:pagedMov/toilet-extra-fonts";
      inputs.nixpkgs.follows = "nixpkgs";
		};
  };

  outputs = {
    nixpkgs,
    nur,
    home-manager,
    self,
    nvim,
    toilet,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    username = "pagedmov";
  in {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          host = "desktop";
          inherit self inputs username;
        };
        inherit system;
        modules = [
          ./hosts/desktop
          nur.nixosModules.nur
        ];
      };

      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          host = "laptop";
          inherit self inputs username;
        };
        modules = [
          ./hosts/laptop
          nur.nixosModules.nur
        ];
      };
    };
  };
}
