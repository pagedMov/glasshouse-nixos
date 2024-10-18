{
  pkgs,
  inputs,
  host,
  ...
}: let
  toilet = inputs.toilet.packages."x86_64-linux".default;
  desktop_pkgs =
    if (host == "oganesson")
    then
      with pkgs; [
        uhk-agent
        zathura
        handbrake
        snes9x-gtk
        obs-studio
      ]
    else [];
in {
  home.packages = with pkgs;
    [
      gtk3
      sqlite
      gimp
      imagemagick
      yt-dlp
      vlc
      lolcat
      speedtest-cli
      vesktop
      qbittorrent
      neovide
      zsh
      zsh-syntax-highlighting
      zsh-history-substring-search
      zsh-autosuggestions
      audacity
      rustup
      libreoffice
      gtrash
      ripgrep
      toilet
      python3
    ]
    ++ desktop_pkgs;
}
