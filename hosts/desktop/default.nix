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
    ./../../modules/sys/configuration.nix
    ./hardware.nix
    ./settings.nix
  ];
}
