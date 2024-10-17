{
  inputs,
  nixpkgs,
  config,
  self,
  username,
  host,
  ...
}: 

let
	desktop_modules = if (host == "oganesson") then [
		./software/virtualization.nix
	] else [ ];
in
{
  imports =
    [(import ./hardware/bootloader.nix)]
    ++ [(import ./hardware/network.nix)]
    ++ [(import ./hardware/impermanence.nix)]
    ++ [(import ./software/fonts.nix)]
    ++ [(import ./software/sddm.nix)]
    ++ [(import ./software/packages.nix)]
    ++ [(import ./software/programs.nix)]
    ++ [(import ./software/services.nix)]
    ++ [(import ./software/users.nix)]
    ++ desktop_modules;
}
