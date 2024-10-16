{pkgs, ...}: {
  system.stateVersion = "24.05";
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      substituters = ["https://nix-gaming.cachix.org"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  environment = {
    variables = {
      XCURSOR_SIZE = "24";
      PATH = "${pkgs.clang-tools}/bin:$PATH";
    };
    shells = with pkgs; [
      zsh
      bash
    ];
  };

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
}
