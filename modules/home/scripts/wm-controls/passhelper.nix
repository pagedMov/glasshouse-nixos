{ self, pkgs, ... }:

pkgs.writeShellScriptBin "passhelper" (''
#!/run/current-system/sw/bin/bash

pass_string=$(find $HOME/.password-store -type f | sed 's|.*/.password-store/||; s|\.gpg$||' | rg -v ".gpg-id$" | fzf)

pass -c "$pass_string"
sleep 1.5
exit 0
'')
