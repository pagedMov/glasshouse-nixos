{
  inputs,
  nixpkgs,
  config,
  self,
  username,
  host,
  ...
}: {
  imports =
    [(import ./hardware/bootloader.nix)]
    ++ [(import ./hardware/network.nix)]
    ++ [(import ./software/fonts.nix)]
    ++ [(import ./software/sddm.nix)]
    ++ [(import ./software/packages.nix)]
    ++ [(import ./software/programs.nix)]
    ++ [(import ./software/services.nix)]
    ++ [(import ./software/users.nix)];
}
