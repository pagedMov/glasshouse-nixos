{
  pkgs,
  config,
  ...
}: {
  fonts.fontconfig.enable = true;
  home.packages = [
  ];

  gtk = {
    enable = true;
  };
}
