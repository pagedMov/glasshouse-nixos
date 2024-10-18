{
  inputs,
  nixpkgs,
  config,
  self,
  username,
  host,
  ...
}: let
  desktop_modules =
    if (host == "oganesson")
    then [
      ./software/virtualization.nix
    ]
    else [];
in {
  imports =
    [(import ./hardware/bootloader.nix)]
    ++ [(import ./hardware/network.nix)]
    ++ [(import ./software/packages.nix)]
    ++ [(import ./software/programs.nix)]
    ++ [(import ./software/services.nix)]
    ++ [(import ./environment/sddm.nix)]
    ++ [(import ./environment/users.nix)]
    ++ [(import ./environment/stylix.nix)]
    ++ desktop_modules;
}
