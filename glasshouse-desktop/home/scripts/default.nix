{ self, pkgs, ... }:  

let
	compress = 		  (import ./compress.nix 		{ self = self; pkgs = pkgs;});
	crs = 			  (import ./crs.nix 			{ self = self; pkgs = pkgs;});
	extract = 		  (import ./extract.nix 		{ self = self; pkgs = pkgs;});
	garbage-collect = (import ./garbage-collect.nix { self = self; pkgs = pkgs;});
	homep = 		  (import ./homep.nix 			{ self = self; pkgs = pkgs;});
	homer = 		  (import ./homer.nix 			{ self = self; pkgs = pkgs;});
	invoke = 		  (import ./invoke.nix 			{ self = self; pkgs = pkgs;});
	lofi = 			  (import ./lofi.nix 			{ self = self; pkgs = pkgs;});
	mcd = 			  (import ./mcd.nix 			{ self = self; pkgs = pkgs;});
	music = 		  (import ./music.nix 			{ self = self; pkgs = pkgs;});
	nixcommit = 	  (import ./nixcommit.nix 		{ self = self; pkgs = pkgs;});
	nixp = 			  (import ./nixp.nix 			{ self = self; pkgs = pkgs;});
	nixr = 			  (import ./nixr.nix 			{ self = self; pkgs = pkgs;});
	nixswitch = 	  (import ./nixswitch.nix 		{ self = self; pkgs = pkgs;});
	nsp = 			  (import ./nsp.nix 			{ self = self; pkgs = pkgs;});
	runbg = 		  (import ./runbg.nix 			{ self = self; pkgs = pkgs;});
	scheck = 		  (import ./s_check.nix 		{ self = self; pkgs = pkgs;});
	shutdown-script = (import ./shutdown-script.nix { self = self; pkgs = pkgs;});
	splash = 		  (import ./splash.nix 			{ self = self; pkgs = pkgs;});
	switchmon =       (import ./switchmon.nix 		{ self = self; pkgs = pkgs;});
	toggle_blur =     (import ./toggle_blur.nix     { self = self; pkgs = pkgs;});
	toggle_float =    (import ./toggle_float.nix 	{ self = self; pkgs = pkgs;});
	toggle_oppacity = (import ./toggle_oppacity.nix { self = self; pkgs = pkgs;});
	toggle_waybar =   (import ./toggle_waybar.nix   { self = self; pkgs = pkgs;});
in
{
	home.packages = [
		splash
		nixswitch 
		garbage-collect 
		mcd 
		crs 
		nixcommit 
		invoke 
		nsp 
		nixp
		nixr
		homep
		scheck
		homer
		runbg
		music
		lofi
		switchmon
		toggle_blur
		toggle_float
		toggle_oppacity
		toggle_waybar
		compress
		extract
		shutdown-script
	];
}
