{ ... }:  

let
	compress = import ./compress.nix;
	crs = import ./crs.nix;
	extract = import ./extract.nix;
	garbage-collect = import ./garbage-collect.nix;
	homep = import ./homep.nix;
	homer = import ./homer.nix;
	invoke = import ./invoke.nix;
	lofi = import ./lofi.nix;
	maxfetch = import ./maxfetch.nix;
	mcd = import ./mcd.nix;
	music = import ./music.nix;
	nixcommit = import ./nixcommit.nix;
	nixp = import ./nixp.nix;
	nixr = import ./nixr.nix;
	nixswitch = import ./nixswitch.nix;
	nsp = import ./nsp.nix;
	record = import ./record.nix;
	runbg = import ./runbg.nix;
	s_check = import ./s_check.nix;
	shutdown-script = import ./shutdown-script.nix;
	splash = import ./splash.nix;
	switchmon = import ./switchmon.nix;
	toggle_blur = import ./toggle_blur.nix;
	toggle_float = import ./toggle_float.nix;
	toggle_oppacity = import ./toggle_oppacity.nix;
	toggle_waybar = import ./toggle_waybar.nix;
in
{
	home.packages = [
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
		s_check
		homer
		runbg
		music
		lofi
		splash
		switchmon
		toggle_blur
		toggle_float
		toggle_oppacity
		toggle_waybar
		maxfetch
		compress
		extract
		shutdown-script
		record
	];
}
