{
  host,
	pkgs,
  self,
  inputs,
  username,
  config,
  ...
}: let
  nur = config.nur;
in {
  imports = [inputs.home-manager.nixosModules.home-manager];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit self inputs host username nur;};
    users.${username} = {
      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = ["qemu:///system"];
          uris = ["qemu:///system"];
        };
      };
      programs.home-manager.enable = true;
      imports = [
        ./programs
				./environment
				./scripts
      ];
      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
        stateVersion = "24.05";
      };
    };
  };

  users = {
    groups.persist = {};
    users = {
      root.initialPassword = "1234";
      ${username} = {
        isNormalUser = true;
        initialPassword = "1234";
        shell = pkgs.zsh;
        extraGroups = ["wheel" "persist" "libvirtd"];
      };
    };
  };
  security.sudo.extraConfig = ''
    ${username} ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/nixos-rebuild
  '';
  nix.settings.allowed-users = ["${username}"];
}
