{
  host,
  inputs,
  username,
  nur,
  pkgs,
  self,
  ...
}: {
  imports = [
    ./../../modules/sys
    ./hardware.nix
    ./impermanence.nix
    ./settings.nix
    ./steam.nix
  ];
}
