{
  description = "Waybar flake with custom configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	waybar = {
		url = "github:Alexays/Waybar";
		inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system} = {
        default = pkgs.waybar.overrideAttrs (oldAttrs: {
          configFile = ./config/config;
        });
      };
    };
}
