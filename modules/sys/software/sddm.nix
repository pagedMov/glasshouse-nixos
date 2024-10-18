{
  pkgs,
  self,
  config,
  ...
}: {
  environment.systemPackages = [
    (
      pkgs.catppuccin-sddm.override {
        flavor = "mocha";
        font = "JetBrains Mono";
        fontSize = "9";
        background = "${self}/media/wallpapers/catppuccin/nixos-catppuccin.png";
      }
    )
  ];
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-mocha";
    package = pkgs.kdePackages.sddm;
  };
}
