{
  host,
  username,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload = ["/home/${username}/Pictures/Wallpapers/cat-leaves.png"];

      wallpaper =
        if (host == "desktop")
        then [
          "DP-1,/home/${username}/Pictures/Wallpapers/cat-leaves.png"
          "HDMI-A-1,/home/${username}/Pictures/Wallpapers/cat-leaves.png"
        ]
        else [
          "eDP-1,/home/${username}/Pictures/Wallpapers/cat-leaves.png"
        ];
    };
  };
}
