{pkgs, ...}: let
  wall-change = pkgs.writeShellScriptBin "wall-change" (builtins.readFile ./scripts/wall-change.sh);
  wallpaper-picker = pkgs.writeShellScriptBin "wallpaper-picker" (builtins.readFile ./scripts/wallpaper-picker.sh);
  
  runbg = pkgs.writeShellScriptBin "runbg" (builtins.readFile ./scripts/runbg.sh);
  music = pkgs.writeShellScriptBin "music" (builtins.readFile ./scripts/music.sh);
  lofi = pkgs.writeScriptBin "lofi" (builtins.readFile ./scripts/lofi.sh);

  splash = pkgs.writeShellScriptBin "splash" (builtins.readFile ./scripts/splash.sh);
  switchmon = pkgs.writeShellScriptBin "switchmon" (builtins.readFile ./scripts/switchmon.sh);
  ls = pkgs.writeShellScriptBin "ls" (builtins.readFile ./scripts/ls.sh);
  nixswitch = pkgs.writeShellScriptBin "nixswitch" (builtins.readFile ./scripts/nixswitch.sh);
  garbage-collect = pkgs.writeShellScriptBin "garbage-collect" (builtins.readFile ./scripts/garbage-collect.sh);
  scheck = pkgs.writeShellScriptBin "scheck" (builtins.readFile ./scripts/s_check.sh);
  cd = pkgs.writeShellScriptBin "cd" (builtins.readFile ./scripts/cd.sh);
  mcd = pkgs.writeShellScriptBin "mcd" (builtins.readFile ./scripts/mcd.sh);
  crs = pkgs.writeShellScriptBin "crs" (builtins.readFile ./scripts/crs.sh);
  nixcommit = pkgs.writeShellScriptBin "nixcommit" (builtins.readFile ./scripts/nixcommit.sh);
  invoke = pkgs.writeShellScriptBin "invoke" (builtins.readFile ./scripts/invoke.sh);
  nsp = pkgs.writeShellScriptBin "nsp" (builtins.readFile ./scripts/nsp.sh);
  
  
  toggle_blur = pkgs.writeScriptBin "toggle_blur" (builtins.readFile ./scripts/toggle_blur.sh);
  toggle_oppacity = pkgs.writeScriptBin "toggle_oppacity" (builtins.readFile ./scripts/toggle_oppacity.sh);
  
  maxfetch = pkgs.writeScriptBin "maxfetch" (builtins.readFile ./scripts/maxfetch.sh);
  
  compress = pkgs.writeScriptBin "compress" (builtins.readFile ./scripts/compress.sh);
  extract = pkgs.writeScriptBin "extract" (builtins.readFile ./scripts/extract.sh);
  
  shutdown-script = pkgs.writeScriptBin "shutdown-script" (builtins.readFile ./scripts/shutdown-script.sh);
  
  show-keybinds = pkgs.writeScriptBin "show-keybinds" (builtins.readFile ./scripts/keybinds.sh);
  
  vm-start = pkgs.writeScriptBin "vm-start" (builtins.readFile ./scripts/vm-start.sh);

  ascii = pkgs.writeScriptBin "ascii" (builtins.readFile ./scripts/ascii.sh);
  
  record = pkgs.writeScriptBin "record" (builtins.readFile ./scripts/record.sh);
in {
  home.packages = [
	ls 
	nixswitch 
	garbage-collect 
	scheck 
	cd 
	mcd 
	crs 
	nixcommit 
	invoke 
	nsp 
    wall-change
    wallpaper-picker
    
    runbg
    music
    lofi

	splash
	switchmon
  
    toggle_blur
    toggle_oppacity

    maxfetch

    compress
    extract

    shutdown-script
    
    show-keybinds

    vm-start

    ascii

    record
  ];
}
