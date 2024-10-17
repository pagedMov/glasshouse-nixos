{
  host,
  username,
  self,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload = ["${self}/media/wallpapers/catppuccin/cat-leaves.png"];

      wallpaper =
        if (host == "oganesson")
        then [
          "DP-1,${self}/media/wallpapers/catppuccin/cat-leaves.png"
          "HDMI-A-1,${self}/media/wallpapers/catppuccin/cat-leaves.png"
        ]
        else [
          "eDP-1,${self}/media/wallpapers/catppuccin/cat-leaves.png"
        ];
    };
  };
}
