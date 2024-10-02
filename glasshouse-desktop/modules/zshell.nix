{
	programs.zsh = {
		enable = true;

		sessionVariables = {
			SOUNDS_ENABLED = "1";
			EDITOR = "/nixbin/nvim";
			SUDO_EDITOR = "/nixbin/nvim";
			VISUAL = "/nixbin/nvim";
			LANG = "en_US.UTF-8";
			BROWSER = "/nixbin/firefox";
			STARSHIP_CONFIG = /home/pagedmov/.config/starship/starship.toml;
			FZF_DEFAULT_COMMAND = "find $HOME \( -path \"$HOME/.steam\" -o -path \"$HOME/.mozilla\" -o -path \"$HOME/go\" \) -prune -o -type f -print";
			GIT_TOKEN = "$(cat supersecret/git-token)";
			PROMPT_COMMAND = "if [[ $? != 0 ]]; then sounds_enabled && (aplay ~/sound/sys/error.wav 2> /dev/null &); fi";
		};

		shellAliases = {
			enterwifi = "nmtui-connect";
			grep = "grep --color=auto";
			v = "nvim";
			mv = "mv -v";
			cp = "cp -vr";
			rm = "safe_rm";
			grub-update = "sudo grub-mkconfig -o /boot/grub/grub.cfg";
			mtar = "tar -zcvf"; # mtar <archive_compress>;
			utar = "tar -zxvf"; # utar <archive_decompress> <file_list>;
			z = "zip -r"; # z <archive_compress> <file_list>;
			uz = "unzip"; # uz <archive_decompress> -d <dir>;
			sr = "source ~/.zshrc";
			".." = "cd ..";
			psg = "ps aux | grep -v grep | grep -i -e VSZ -e" ;
			mkdir = "mkdir -p";
			fm = "ranger";
			killjob = "kill -9 \$(jobs -l | awk '{print \$3}')";
			rmf = "fzf -m | xargs -ro rm";
			nwt = "ping google.com";
			wiki = "vimwiki";
			uwiki = "wiki_update";
			beep = "paplay $BEEP";
			pk = "pkill -9 -f";
			zrc = "nvim $HOME/sysflakes/glasshouse-desktop/modules/zshell.nix";
			vfind = "nvim_find";
			theme = "change_kitty_theme";
			navhelp = "navhelp | less";
			svc = "systemctl --user";
			hmswitch = "home-manager switch";
			hyprconf = "nvim $HOME/sysflakes/glasshouse-desktop/dotfiles/packages/hyprland/hyprland.conf";
			hmconf = "nvim $HOME/sysflakes/glasshouse-desktop/home.nix";
			nixconf = "nvim $HOME/sysflakes/glasshouse-desktop/configuration.nix";
			viflake = "nvim flake.nix";
			nvimcfg = "ranger $HOME/sysflakes/glasshouse-desktop/dotfiles/packages/nixvim/";
		};

		initExtraFirst = ''
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.nix-profile/bin:$PATH"
export UPDATE_ZSH_DAYS=7

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

if [[ $- != *i* ]]; then
	return
fi

typeset -g comppath="$HOME/.cache"
typeset -g compfile="$comppath/.zcompdump"

if [[ -d "$comppath" ]]; then
	[[ -w "$compfile" ]] || rm -rf "$compfile" >/dev/null 2>&1
else
	mkdir -p "$comppath"
fi

sounds_enabled() {[ "$SOUNDS_ENABLED" -eq "1" ]}


preexec() {
    cmdcounter="/tmp/cmdcounter_$(whoami)"
    
    if [[ ! -f "$cmdcounter" ]]; then
        echo 0 > "$cmdcounter"
    fi

    cmd_count="$(cat "$cmdcounter")"
    
    cmd_count=$((cmd_count + 1))
    
    echo "$cmd_count" > "$cmdcounter"
}

snd_restart() {
	echo -n "Restarting wireplumber service... "
	systemctl --user restart wireplumber; code1=$? && echo "SUCCESS" || echo "FAILED"
	[ $code1 -ne 0 ] && exit 1
	echo -n "Restarting pipewire service... "
	systemctl --user restart pipewire; code2=$? && echo "SUCCESS" || echo "FAILED"
	[ $code2 -ne 0 ] && exit 1
	echo "Audio services successfully restarted"
}

vid_restart() {
	echo -n "Restarting wireplumber service... "
	systemctl --user restart wireplumber; code1=$? && echo "SUCCESS" || echo "FAILED"
	[ $code1 -ne 0 ] && exit 1
	echo -n "Restarting pipewire service... "
	systemctl --user restart pipewire; code2=$? && echo "SUCCESS" || echo "FAILED"
	[ $code2 -ne 0 ] && exit 1
	echo -n "Restarting xdg-desktop-portal service... "
	systemctl --user restart xdg-desktop-portal; code3=$? && echo "SUCCESS" || echo "FAILED"
	[ $code3 -ne 0 ] && exit 1
	echo -n "Restarting xdg-desktop-portal-hyprland service... "
	systemctl --user restart xdg-desktop-portal-hyprland; code4=$? && echo "SUCCESS" || echo "FAILED"
	[ $code4 -ne 0 ] && exit 1
	echo "Video services successfully restarted"
}

wiki_update() {
	old_pwd=$(pwd)
	cd ~/vimwiki > /dev/null
	git pull
	cd $old_pwd > /dev/null
}

# Functions
ls() {
  command ls --group-directories-first --color=always -F1 "$@" | sort -f -k1
  sounds_enabled && (aplay ~/sound/sys/ls.wav > /dev/null 2>&1 &)
}

# cd and ls after
cd() {
	export SOUNDS_ENABLED=0
	ls "$@"
	builtin cd "$@" 
	export SOUNDS_ENABLED=1
	sounds_enabled && (aplay ~/sound/sys/cd.wav > /dev/null 2>&1 &)
}
src() {
	autoload -U zrecompile
	rm -rf "$compfile"*
	compinit -u -d "$compfile"
	zrecompile -p "$compfile"
	exec zsh
}

mcd () {
    mkdir -p $1
    cd $1
}

rc(){
  g++ "$1" -o run
  ./run
}

safe_rm() {
	played_sound=false
    for dir in "$@"; do
        # Check if it's a file or directory
        if [ -d "$dir" ] || [ -f "$dir" ]; then
            # Get size of the directory or file
            size=$(du -s "$dir" 2>/dev/null | awk '{print $1/1024}' | awk '{printf("%d\n", $1 + 0.5)}')
            
            # Count files (recursively if it's a directory)
            files=$(find "$dir" | wc -l)

            check=false
            is_file_or_dir=$([ -f "$dir" ] && echo 'file' || echo 'directory')

            # If there are many files, or the size is big, warn the user
            if [ "$files" -gt 20 ]; then
                echo "There's a lot of stuff in '$dir' ($files files) ."
                check=true
            fi

            if [ "$size" -gt 1024 ]; then
                size_in_gb=$(echo "scale=2; $size / 1024" | bc -l)
                echo "This $is_file_or_dir ('$dir') is kind of big ($size_in_gb GB)."
                check=true
            fi

            # Ask for confirmation only if necessary
            if [ "$check" = true ]; then
                echo "Are you sure you want to remove this $is_file_or_dir '$dir'? (y/n)"
                read -r confirm
				[ "$confirm" = "y" ] && (aplay ~/sound/sys/rm.wav > /dev/null 2>&1 &)
				[ "$confirm" != "y" ] && (aplay ~/sound/sys/cd.wav > /dev/null 2>&1 &)
            fi

            # Perform the removal if no checks or confirmation is "y"
            if [ "$check" = false ] || [ "$confirm" = "y" ]; then
                /run/current-system/sw/bin/rm -rfv "$dir"
				[[ "$played_sound" -eq "0" ]] && (aplay ~/sound/sys/rm.wav > /dev/null 2>&1 &)
				played_sound=1
            else
                echo "Operation cancelled for '$dir'."
            fi
        else
            echo "'$dir' does not exist or is not accessible."
        fi
    done
}

nix-beep() {
	sounds_enabled && (aplay ~/sound/sys/nixswitch-start.wav > /dev/null 2>&1 &)
	nix "$@" 
	if [ "$?" -eq "0" ]; then 
		sounds_enabled && (aplay ~/sound/sys/update.wav > /dev/null 2>&1 &)
	else
		sounds_enabled && (aplay ~/sound/sys/error.wav > /dev/null 2>&1 &)
	fi
}

nixswitch() {
	sounds_enabled && (aplay ~/sound/sys/nixswitch-start.wav > /dev/null 2>&1 &)
	builtin cd "$HOME/sysflakes"
	nix flake update
	
	gen=$(readlink /nix/var/nix/profiles/system | sed 's/.*system-\([0-9]*\)-link/\1/')
	gen=$((gen + 1))
	
	if git diff --cached --quiet ; then
		git add .
		git commit -m "Commit for generation $gen"
		git push
	fi
	sudo nixos-rebuild switch --flake "$HOME/sysflakes#glasshouse"
	builtin cd $OLDPWD
	if [ $? -eq 0 ]; then 
		sounds_enabled && (aplay ~/sound/sys/update.wav > /dev/null 2>&1 &)
	else
		sounds_enabled && (aplay ~/sound/sys/error.wav > /dev/null 2>&1 &)
	fi
}
journal() {
	# journal for keeping track of stuff I do that isn't declared in my nix config
	[ ! -f "$HOME/loose_ends" ] && touch "$HOME/loose_ends" 
	echo "$(date) - $1" >> "$HOME/loose_ends" 
}
invoke() { nix run nixpkgs#"$@" }

		'';

		initExtraBeforeCompInit = ''
			source ~/.zstyle
		'';
		initExtra = ''
if [ ! -e $HOME/.zsh_history ]; then
	touch $HOME/.zsh_history
	chmod 600 $HOME/.zsh_history
fi
HISTFILE=~/.zsh_history   # The file where your history will be saved
HISTSIZE=10000            # The number of lines kept in memory
SAVEHIST=10000            # The number of lines kept in the history file
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


bindkey "^[[H" beginning-of-line # home key
bindkey "^[[F" end-of-line # end key
bindkey "^[[3~" delete-char # delete key

autoload -U compinit     # completion
autoload -U terminfo     # terminfo keys
zmodload -i zsh/complist # menu completion
autoload -U promptinit   # prompt

autoload -U up-line-or-beginning-search; zle -N up-line-or-beginning-search
autoload -U down-line-or-beginning-search; zle -N down-line-or-beginning-search



if [ "$TERM" = "linux" ] ; then
	echo -en "\e]P0232323"
fi

~/coding/scripts/splash.sh
eval "$(starship init zsh)"
(aplay ~/sound/sys/sh-source.wav > /dev/null 2>&1 &)
		'';

		# Options

		enableCompletion = true;
		history = {
			path = ".zsh_history";
			save = 10000;
			size = 10000;
			share = true;
		};
		autosuggestion = { 
			enable = true;
			highlight = "fg=#4C566A,underline";
		};

	};
}
