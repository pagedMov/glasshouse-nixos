{
  inputs,
  host,
  ...
}: let
  host_config =
    if (host == "oganesson")
    then [./desktop.nix]
    else [./laptop.nix];
in {
  imports =
    [(import ./hyprland.nix)]
    ++ [(import ./hyprpaper.nix)]
    ++ host_config;
}
