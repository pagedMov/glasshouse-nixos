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

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
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
      oganesson = nixpkgs.lib.nixosSystem {
        specialArgs = {
          host = "oganesson";
          inherit self inputs username;
        };
        inherit system;
        modules = [
          ./hosts/desktop
          inputs.disko.nixosModules.default
          inputs.impermanence.nixosModules.impermanence
          (import ./disko.nix {device = "/dev/nvme0n1";})
          nur.nixosModules.nur
        ];
      };

      mercury = nixpkgs.lib.nixosSystem {
        specialArgs = {
          host = "mercury";
          inherit self inputs username;
        };
        modules = [
          ./hosts/laptop
          inputs.disko.nixosModules.default
          inputs.impermanence.nixosModules.impermanence
          (import ./disko.nix {device = "/dev/nvme0n1";})
          nur.nixosModules.nur
        ];
      };

			installer = nixpkgs.lib.nixosSystem {
				specialArgs = {
					host = "installer";
					inherit self inputs;
				};
				modules = [
					./hosts/installer
					inputs.disko.nixosModules.default
					inputs.impermanence.nixosModules.impermanence
				];
			};
    };
  };
}
