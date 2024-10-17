{ lib, inputs, pkgs, modulesPath, ... }:

let
	nvim = inputs.nvim.packages."x86_64-linux".default;
	toilet = inputs.toilet.packages."x86_64-linux".default;
	install-script = pkgs.writeShellScriptBin "movcfg-install" ''
		#!/bin/bash
		set -e
		trap 'echo "Aborting installation."; exit 1' INT

		# set up working directory
		mkdir -p /tmp/install_pwd && cd /tmp/install_pwd
		rm -rf ./*

		# download disko.nix file for defining partitions
		echo "Downloading partition map... "
		curl https://raw.githubusercontent.com/vimjoyer/impermanent-setup/main/final/disko.nix > disko.nix

		lsblk -d -o NAME,SIZE
		echo
		echo "This script is about to format and partition a hard drive."
		sleep 2
		echo -e "\033[4;31mThis process is irreversible and will destroy all data on the drive.\033[0m"
		sleep 2
		echo "Make absolutely sure that you know which drive you are choosing. Abort with Ctrl+C if you aren't sure which one to use."
		sleep 2
		echo -n "Which drive do you wish to sacrifice? "
		read -r drive

		# commence formatting
		nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/install_pwd/disko.nix --arg device "\"/dev/$drive\""

		# set up home directory in /mnt/persist, create /persist/etc/nixos, cd to /etc/nixos and install my flake config
		mkdir -p /mnt/persist/{etc/nixos,home}
		mkdir -p /mnt/etc
		cd /mnt/etc/
		git clone https://github.com/pagedMov/pagedmov-nix-cfg.git ./nixos

		nixos-install --root /mnt --flake /mnt/etc/nixos#mercury --no-root-password

		echo
		echo "Preliminary installation successful!"
		echo "Beginning secondary installation phase... "
		echo

		cp -r /mnt/etc/nixos /mnt/persist/home/.sysflake
		rm -rf /mnt/etc/nixos/*

		nixos-enter <<EOF
chmod -R 770 /persist
chown -R :persist /persist
NIXOS_SWITCH_USE_DIRTY_ENV=1 nixos-rebuild boot --flake /persist/home/.sysflake#mercury
EOF

		echo "INSTALLATION COMPLETE ! !" | toilet -f 3d -w 120 | lolcat -a -s 180
		echo "You can now reboot into your new system."
		echo "The system configuration flake will be found in your home folder under .sysflake"
	'';
in
{
	imports = [
		"${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
	];
	nixpkgs.hostPlatform = "x86_64-linux";
	system.stateVersion = "24.05";
	nix = {
		settings = {
			experimental-features = ["nix-command" "flakes"];
		};
	};

	networking = {
		wireless.enable = false;
		networkmanager.enable = true;
	};

	environment.systemPackages = with pkgs; [
		nvim
		nix-output-monitor
		nh
		nvd
		lolcat
		curl
		wget
		coreutils
		findutils
		zip
		unzip
		util-linux
		git
		btrfs-progs
		dosfstools
		parted
		pciutils
		usbutils
		toilet
		install-script
	];
	
	services = {
		openssh.enable = true; 
		dbus.enable=true;
	};

  programs.zsh = {
    enable = true;

    ohMyZsh = {
      enable = true;
      plugins = ["git" "fzf"];
    };

    enableCompletion = true;
    
		histFile = "$HOME/.zsh_history";
		histSize = 10000;

    autosuggestions = {
      enable = true;
      highlightStyle = "fg=#4C566A,underline";
    };

    shellAliases = {
      grep = "grep --color=auto";
      yazi = "y";
      vi = "nvim";
      mv = "mv -v";
      cp = "cp -vr";
      gt = "gtrash";
      gtp = "gtrash put";
      grub-update = "sudo grub-mkconfig -o /boot/grub/grub.cfg";
      sr = "source ~/.zshrc";
      ".." = "cd ..";
      rm = "echo 'use \"gtp\" instead'";
      psg = "ps aux | grep -v grep | grep -i -e VSZ -e";
      mkdir = "mkdir -p";
      pk = "pkill -9 -f";
      svcu = "systemctl --user";
      svc = "sudo systemctl";
      viflake = "nvim flake.nix";
    };
		promptInit = ''
      bindkey -v
      type starship_zle-keymap-select >/dev/null || \
      {
      	eval "$(starship init zsh)"
      }
		'';
		setOptions = [
      "APPEND_HISTORY"     
      "INC_APPEND_HISTORY" 
      "SHARE_HISTORY"      
      "CORRECT"
      "NO_NOMATCH"
      "LIST_PACKED"
      "ALWAYS_TO_END"
      "GLOB_COMPLETE"
      "COMPLETE_ALIASES"
      "COMPLETE_IN_WORD"
      "AUTO_CD"
      "AUTO_CONTINUE"
      "LONG_LIST_JOBS"
      "HIST_VERIFY"
      "SHARE_HISTORY"
      "HIST_IGNORE_SPACE"
      "HIST_SAVE_NO_DUPS"
      "HIST_IGNORE_ALL_DUPS"
      "EXTENDED_GLOB"
      "TRANSIENT_RPROMPT"
      "INTERACTIVE_COMMENTS"
		];
    shellInit = ''
      export EDITOR="nvim"
      export SUDO_EDITOR="nvim"
      export VISUAL="nvim"
      export LANG="en_US.UTF-8"

      unalias ls
      ls() {
      	eza -1 --group-directories-first --icons "$@"
      }

      y() {
      	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
      	yazi "$@" --cwd-file="$tmp"
      	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      		builtin cd -- "$cwd"
      	fi
      	rm -f -- "$tmp"
      }

      cd() {
      	export SOUNDS_ENABLED=0
      	eza -1 --group-directories-first --icons "$@"
      	builtin cd "$@" || exit
      	export SOUNDS_ENABLED=1
      }
      if [ ! -e $HOME/.zsh_history ]; then
      	touch $HOME/.zsh_history
      	chmod 600 $HOME/.zsh_history
      fi

      autoload -U compinit     # completion
      autoload -U terminfo     # terminfo keys
      zmodload -i zsh/complist # menu completion
      autoload -U promptinit   # prompt

      autoload -U up-line-or-beginning-search; zle -N up-line-or-beginning-search
      autoload -U down-line-or-beginning-search; zle -N down-line-or-beginning-search

      unalias ls
      clear
    '';
	};
  programs.starship = {
    enable = true;
    settings =
      {
        add_newline = true;
        right_format = "($custom)";

        format = lib.concatStrings [
          "($username)(bold white)($cmd_duration)($character)"
          "($git_branch)($git_status)($rust)($nix-shell)"
          "($directory)"
          "$line_break[ > ](bold #89b4fa)"
        ];

        username = {
          show_always = true;
          style_user = "bold white";
          format = "[$user]($style)";
        };
        directory = {
          format = "\n[$path](bold cyan)[/](bold green) ";
          style = "bold #b4befe";
        };

        character = {
          success_symbol = "[ -> ](bold green)";
          error_symbol = "[ -> ✗](bold red)";
          # error_symbol = "[ ](bold #89dceb)[ ✗](bold red)";
        };

        cmd_duration = {
          format = "[ 󰔛 $duration]($style)";
          disabled = false;
          style = "bg:none fg:#f9e2af";
          show_notifications = false;
          min_time_to_notify = 60000;
        };

        git_branch = {
          format = "\non [$symbol$branch](bold purple)";
          symbol = " ";
          truncation_length = 15;
          style = "bold purple";
        };

        custom.shellver = {
          command = "zsh --version";
          when = ''test $SHELL = "/run/current-system/sw/bin/zsh"'';
          symbol = "";
          style = "bold magenta";
        };

        palette = "catppuccin_mocha";
      }
      // builtins.fromTOML (builtins.readFile "${inputs.catppuccin-starship}/themes/mocha.toml");
  };
}
