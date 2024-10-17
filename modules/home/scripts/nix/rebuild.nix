{
  host,
  self,
  pkgs,
}:
pkgs.writeShellScriptBin "rebuild" ''
  #!/run/current-system/sw/bin/bash

  scheck && runbg aplay ${self}/media/sound/nixswitch-start.wav
  set -e
  pushd "$HOME/.sysflake"

  nix flake update
  sudo nixos-rebuild switch --flake "$HOME/.sysflake#${host}"
  if [ $? -eq 0 ]; then
  	scheck && runbg aplay ${self}/media/sound/update.wav
  else
  	scheck && runbg aplay ${self}/media/sound/error.wav
  fi
  popd
''
