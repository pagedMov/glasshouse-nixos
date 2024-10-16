{
  self,
  pkgs,
  ...
}:
pkgs.writeShellScriptBin "passhelper" ''
  #!/run/current-system/sw/bin/bash

  	# prevent multiple instances, conditional check happens in the hyprland bind
  touch /tmp/passhelperfile
  trap "[ -f /tmp/passhelperfile ] && /run/current-system/sw/bin/rm /tmp/passhelperfile" EXIT SIGHUP SIGINT

  	# get passwords from password store, remove .password store/ prefix and .gpg suffix, exlude .gpg-id file, open results in fzf
  pass_string=$(find $HOME/.password-store -type f | sed 's|.*/.password-store/||; s|\.gpg$||' | sed 's|^\([^/]*\)|\x1b[32m\1\x1b[0m|' | rg -v "\.git|.gpg-id" | sort -r | fzf --border --border-label="$(whoami)'s keyring" --ansi --layout=reverse)

  [ $? = 0 ] || { [ -f /tmp/passhelperfile ] && /run/current-system/sw/bin/rm /tmp/passhelperfile; exit 1; }

  	# pass it through fmt for soft word wrapping
  pass -c "$pass_string" | fmt -w 45
  /run/current-system/sw/bin/rm /tmp/passhelperfile
  sleep 0.5
  exit 0
''
