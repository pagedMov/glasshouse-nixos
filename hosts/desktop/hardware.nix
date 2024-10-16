# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/20e746a4-a39d-4adc-af51-48d0bd09db88";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };

  fileSystems."/persist" =
    { device = "/dev/disk/by-uuid/20e746a4-a39d-4adc-af51-48d0bd09db88";
      fsType = "btrfs";
      options = [ "subvol=persist" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/20e746a4-a39d-4adc-af51-48d0bd09db88";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

  fileSystems."/var/lib/nixos" =
    { device = "/nix/persist/system/var/lib/nixos";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/var/log" =
    { device = "/nix/persist/system/var/log";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/etc/NetworkManager/system-connections" =
    { device = "/nix/persist/system/etc/NetworkManager/system-connections";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/etc/nixos" =
    { device = "/nix/persist/system/etc/nixos";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/var/lib/bluetooth" =
    { device = "/nix/persist/system/var/lib/bluetooth";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/var/lib/systemd/coredump" =
    { device = "/nix/persist/system/var/lib/systemd/coredump";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/4120-EAB9";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/27521c6c-aabb-4e3e-90b1-8fa16fba82f8"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp14s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
