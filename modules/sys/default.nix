{ inputs, nixpkgs, config, self, username, host, ... }:

{
	imports = 
		[ (import ./hardware/bootloader.nix) ]
	 ++ [ (import ./software/fonts.nix) 	 ]
	 ++ [ (import ./hardware/network.nix) 	 ]
	 ++ [ (import ./software/packages.nix)   ]
	 ++ [ (import ./software/programs.nix)   ]
	 ++ [ (import ./software/services.nix)   ]
	 ++ [ (import ./software/users.nix)      ];
}
