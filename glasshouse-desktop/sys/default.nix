{ inputs, nixpkgs, config, username, ... }:

{
	imports = 
		[ (import ./bootloader.nix) ]
	 ++ [ (import ./fonts.nix) ]
	 ++ [ (import ./hardware.nix) ]
	 ++ [ (import ./network.nix) ]
	 ++ [ (import ./packages.nix) ]
	 ++ [ (import ./programs.nix) ]
	 ++ [ (import ./services.nix) ]
	 ++ [ (import ./system.nix) ]
	 ++ [ (import ./users.nix) ];
}
