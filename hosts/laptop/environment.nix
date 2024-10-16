{pkgs, ...}: {
  environment = {
    variables = {
      XCURSOR_SIZE = "24";
      PATH = "${pkgs.clang-tools}/bin:$PATH";
    };
    shells = with pkgs; [
      zsh
      bash
    ];
    systemPackages = with pkgs; [
      acpi
      brightnessctl
      cpupower-gui
      powertop
    ];
  };
}
