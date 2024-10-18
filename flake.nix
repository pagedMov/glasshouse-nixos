{
  description = "pagedMov's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    stylix.url = "github:danth/stylix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };

    spicetify-nix = {
      url = "github:gerg-l/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim = {
      url = "github:pagedMov/pagedmov-nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    stylix,
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
          stylix.nixosModules.stylix
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
          stylix.nixosModules.stylix
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
        ];
      };
    };
  };
}
