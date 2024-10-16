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
    starship
    zathura
    imagemagick
    yt-dlp
    vlc
    speedtest-cli
    vesktop
    obs-studio
    neovide
    chromium
    zsh
    zsh-syntax-highlighting
    zsh-history-substring-search
    zsh-autosuggestions
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
