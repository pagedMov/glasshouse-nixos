{
  pkgs,
  self,
  config,
  ...
}: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
  };
}
