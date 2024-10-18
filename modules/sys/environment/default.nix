
{
  inputs,
  nixpkgs,
	nixvim,
  config,
  self,
  username,
  host,
  ...
}:  {
  imports = 
		[(import ./sddm.nix)]
		++ [(import ./stylix.nix)];
}

