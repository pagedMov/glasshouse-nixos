{ ... }:

{
	programs.zoxide = {
	 enable = true;
	 enableZshIntegration = true;
	};
	programs.zsh = {
		enable = true;

		sessionVariables = {
			SOUNDS_ENABLED = "1";
			EDITOR = "/nixbin/nvim";
			SUDO_EDITOR = "/nixbin/nvim";
			VISUAL = "/nixbin/nvim";
			LANG = "en_US.UTF-8";
			BROWSER = "/nixbin/firefox";
		};

		oh-my-zsh = {
			enable = true;
			plugins = [ "git" "fzf" ];
		};

		enableCompletion = true;
		history = {
			path = "$HOME/.zsh_history";
			save = 10000;
			size = 10000;
			share = true;
		};

		autosuggestion = { 
			enable = true;
			highlight = "fg=#4C566A,underline";
		};

		shellAliases = {
			grep = "grep --color=auto";
			mv = "mv -v";
			cp = "cp -vr";
			gt = "gtrash";
			grub-update = "sudo grub-mkconfig -o /boot/grub/grub.cfg";
			sr = "source ~/.zshrc";
			".." = "cd ..";
			psg = "ps aux | grep -v grep | grep -i -e VSZ -e" ;
			mkdir = "mkdir -p";
			pk = "pkill -9 -f";
			zrc = "nvim $HOME/dots/zsh/zshell.nix";
			svcu = "systemctl --user";
			svc = "sudo systemctl";
			hyprconf = "nvim $HOME/dots/hyprland/config.nix";
			nixconf = "nvim $HOME/sysflakes/glasshouse-desktop/sys";
			hmconf = "nvim $HOME/sysflakes/glasshouse-desktop/home";
			viflake = "nvim flake.nix";
			nvimcfg = "nvim $HOME/dots/nixvim/config";
			zsr = "runbg kitty zsh && kitty @ close-window";
		};
		initExtraFirst = ''

s_check() { [ $SOUNDS_ENABLED -eq 1 ] }

unalias ls
ls() {
	eza -1 --group-directories-first --icons "$@"
	s_check && runbg aplay ~/sound/sys/ls.wav
}

cd() {
	export SOUNDS_ENABLED=0
	eza -1 --group-directories-first --icons "$@"
	builtin cd "$@" 
	export SOUNDS_ENABLED=1
	s_check && (aplay ~/sound/sys/cd.wav > /dev/null 2>&1 &)
}

mcd() {
	mkdir -p $1
	cd $1
}

crs() {
	cargo test && \
	cargo run
}

nixcommit() {
	s_check && (aplay ~/sound/sys/nixswitch-start.wav > /dev/null 2>&1 &)
	builtin cd "$HOME/sysflakes"
	nix flake update
	
	gen=$(readlink /nix/var/nix/profiles/system | sed 's/.*system-\([0-9]*\)-link/\1/')
	gen=$((gen + 1))

	git diff --quiet
	if [ $? -eq 0 ]; then
		echo "Nothing to commit"
		return
	fi
	git add .
	git commit -m "Gen $gen: $@"
	git push
	builtin cd -
}

nixswitch() {
	s_check && (aplay ~/sound/sys/nixswitch-start.wav > /dev/null 2>&1 &)
	builtin cd "$HOME/sysflakes"

	nix flake update
	sudo nixos-rebuild switch --flake "$HOME/sysflakes#glasshouse"
	if [ $? -eq 0 ]; then 
		s_check && (aplay ~/sound/sys/update.wav > /dev/null 2>&1 &)
	else
		s_check && (aplay ~/sound/sys/error.wav > /dev/null 2>&1 &)
	fi
	builtin cd $OLDPWD
}

invoke() { nix run nixpkgs#$"@" }

nsp() { nix-shell -p "$@" --run zsh }
		'';

	initExtra = ''
		if [ ! -e $HOME/.zsh_history ]; then
			touch $HOME/.zsh_history
			chmod 600 $HOME/.zsh_history
		fi
		setopt APPEND_HISTORY     # Append history to the history file (don't overwrite)
		setopt INC_APPEND_HISTORY # Append to the history file incrementally
		setopt SHARE_HISTORY      # Share history between all zsh sessions
		setopt CORRECT
		setopt NO_NOMATCH
		setopt LIST_PACKED
		setopt ALWAYS_TO_END
		setopt GLOB_COMPLETE
		setopt COMPLETE_ALIASES
		setopt COMPLETE_IN_WORD
		setopt AUTO_CD
		setopt AUTO_CONTINUE
		setopt LONG_LIST_JOBS
		setopt HIST_VERIFY
		setopt SHARE_HISTORY
		setopt HIST_IGNORE_SPACE
		setopt HIST_SAVE_NO_DUPS
		setopt HIST_IGNORE_ALL_DUPS
		setopt EXTENDED_GLOB
		setopt TRANSIENT_RPROMPT
		setopt INTERACTIVE_COMMENTS

		autoload -U compinit     # completion
		autoload -U terminfo     # terminfo keys
		zmodload -i zsh/complist # menu completion
		autoload -U promptinit   # prompt

		autoload -U up-line-or-beginning-search; zle -N up-line-or-beginning-search
		autoload -U down-line-or-beginning-search; zle -N down-line-or-beginning-search

		bindkey -v
		type starship_zle-keymap-select >/dev/null || \
		{
			eval "$(starship init zsh)"
		}
		clear
		splash
		s_check && (aplay ~/sound/sys/sh-source.wav > /dev/null 2>&1 &)
	'';
	};

}

