{
  pkgs,
  inputs,
  ...
}: let
  nvim = inputs.nvim.packages."x86_64-linux".default;
  toilet = inputs.toilet.packages."x86_64-linux".default;
in {
  home.packages = with pkgs; [
    gtk3
    uhk-agent
    sqlite
    zathura
    gimp
    imagemagick
    yt-dlp
    vlc
    lolcat
    speedtest-cli
    vesktop
    qbittorrent
    obs-studio
    neovide
    zsh
    zsh-syntax-highlighting
    zsh-history-substring-search
    zsh-autosuggestions
    audacity
    snes9x-gtk
    rustup
    libreoffice
    handbrake
    gtrash
    ripgrep
    nvim
    toilet
    python3
  ];
}
