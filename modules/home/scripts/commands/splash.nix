{
  self,
  pkgs,
}:
pkgs.writeShellScriptBin "splash" ''
  #!/bin/bash

  echo "NixOS kernel ver. $(uname -a | awk '{print $3}') x86_64 GNU/Linux"
  date +"%A %B %-d %Y"
  echo -e "\033[38;2;0;180;205m$(toilet -t -f Slant.flf glasshouse)\033[0m"
  echo
''
