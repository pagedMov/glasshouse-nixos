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
    ./settings.nix
    ./steam.nix
  ];
}
