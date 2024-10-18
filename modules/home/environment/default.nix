{
  host,
  nur,
	nixvim,
  self,
  inputs,
  username,
  config,
  home-manager,
  ...
}: {
  imports =
    [(import ./gtk.nix)]
    ++ [(import ./spicetify.nix)]
    ++ [(import ./starship.nix)]
    ++ [(import ./userpkgs.nix)]
    ++ [(import ./zshell.nix)]
    ++ [(import ./waybar)]
    ++ [(import ./hyprland)]
    ++ [(import ./swaync)];
}
