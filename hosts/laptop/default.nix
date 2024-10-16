{
  host,
  inputs,
  pkgs,
  config,
  self,
  username,
  ...
}: {
  imports = [
    ./../../modules/sys
    ./hardware.nix
    ./boot.nix
    ./services.nix
    ./environment.nix
    ./settings.nix
  ];
}
