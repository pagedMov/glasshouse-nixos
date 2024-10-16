{
  config,
  inputs,
  pkgs,
  username,
  self,
  host,
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
      programs.home-manager.enable = true;
      imports = [
				inputs.impermanence.nixosModules.home-manager.impermanence
				./../../home
			];
      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
        stateVersion = "24.05";
        pointerCursor = {
          name = "Quintom_Ink";
          size = 36;
          package = pkgs.quintom-cursor-theme;
        };
      };
    };
  };
  users = {
		groups.persist = { };
		users = {
			root.hashedPassword = "$y$j9T$/eZO.0cE2EcsF4od78laE/$A3kqgNhr6LkUZHI/0MXAhk.SSKk7QsCIwH/l6xeryy8";
			${username} = {
				isNormalUser = true;
				hashedPassword = "$y$j9T$pdvRk/.3GbwvcPw0NTdwW0$ugclmwwlOO7iKLcJY4DkyD2tX6.LS26LHQ//0W1zLQ.";
				shell = pkgs.zsh;
				extraGroups = ["wheel" "persist"];
			};
		};
	};
  security.sudo.extraConfig = ''
    ${username} ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/nixos-rebuild
  '';
  nix.settings.allowed-users = ["${username}"];
}
