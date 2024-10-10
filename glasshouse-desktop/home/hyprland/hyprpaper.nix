{ ... }:

{
	services.hyprpaper = {
		enable = true;
		settings = {
			ipc = "on";
			splash = false;
			splash_offset = 2.0;
			preload = [ "/home/pagedmov/Pictures/Wallpapers/cat-leaves.png" ];

			wallpaper = [
				"DP-1,/home/pagedmov/Pictures/Wallpapers/cat-leaves.png" 
				"HDMI-A-1,/home/pagedmov/Pictures/Wallpapers/cat-leaves.png" 
			];
		};
	};
}
