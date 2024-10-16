{
  description = "Toilet Configuration with Extra Fonts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    # Fetch extra fonts from GitHub
    extraFonts = pkgs.fetchFromGitHub {
      owner = "xero";
      repo = "figlet-fonts";
      rev = "master"; # Or specify a particular commit/tag
      sha256 = "sha256-dAs7N66D2Fpy4/UB5Za1r2qb1iSAJR6TMmau1asxgtY="; # Replace with actual hash
    };
  in {
    packages.${system} = {
      default = pkgs.toilet.overrideAttrs (oldAttrs: rec {
        buildInputs = oldAttrs.buildInputs or [] ++ [extraFonts];

        installPhase = ''
          make install PREFIX=$out

          # Copy the extra fonts into the correct directory
          mkdir -p $out/share/figlet
          cp -r ${extraFonts}/* $out/share/figlet
        '';
      });
    };

    # Define a development shell for testing
    devShells.${system} = pkgs.mkShell {
      buildInputs = [
        pkgs.toilet
        extraFonts
      ];

      shellHook = ''
        echo "Toilet dev shell with extra fonts"
      '';
    };
  };
}
