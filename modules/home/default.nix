{
  host,
  nur,
  self,
  inputs,
  username,
  config,
  home-manager,
  ...
}: 

let
	desktop_modules = if (host == "onagesson") then
		[(import ./programs/steam.nix)] else [];
in
{
  imports =
    [(import ./programs/btop.nix)]
    ++ [(import ./programs/yazi.nix)]
    ++ [(import ./programs/kitty.nix)]
    ++ [(import ./programs/fuzzel.nix)]
    ++ [(import ./programs/eza.nix)]
    ++ [(import ./programs/cava.nix)]
    ++ [(import ./programs/bat.nix)]
    ++ [(import ./programs/fzf.nix)]
    ++ [(import ./programs/git.nix)]
    ++ [(import ./programs/password-store.nix)]
    ++ [(import ./programs/autojump.nix)]
    ++ [(import ./programs/firefox.nix)]
    ++ [(import ./environment/gtk.nix)]
    ++ [(import ./environment/spicetify.nix)]
    ++ [(import ./environment/starship.nix)]
    ++ [(import ./environment/desktop_userpkgs.nix)]
    ++ [(import ./environment/zshell.nix)]
    ++ [(import ./waybar)]
    ++ [(import ./hyprland)]
    ++ [(import ./scripts)]
    ++ [(import ./swaync/swaync.nix)]
		++ desktop_modules;
}
