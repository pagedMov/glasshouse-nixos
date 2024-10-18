#!/run/current-system/sw/bin/bash
set -e
trap 'echo "Aborting installation."; exit 1' INT

# set up working directory
mkdir -p /tmp/install_pwd && cd /tmp/install_pwd
rm -rf ./*

# download disko.nix file for defining partitions
echo -n "Downloading partition plan..."
curl -s https://raw.githubusercontent.com/pagedMov/pagedmov-nix-cfg/refs/heads/master/hosts/installer/disko-ext4-singledisk.nix > disko.nix
echo "Done!"

echo
echo "This script is about to format and partition a hard drive."
sleep 2.5
echo -e "\033[4;31mThis process is irreversible and will destroy all data on the drive.\033[0m"
sleep 2.5
echo "Make absolutely sure that you know which drive you are choosing."
sleep 2.5
echo
lsblk -d -o NAME,SIZE
echo
echo -n "Which drive do you wish to sacrifice? "
read -r drive

size=$(lsblk -b -d -o NAME,SIZE | grep "$drive" | awk '{ printf "%.0f\n", $2 / 1024 / 1024 / 1024 }')
root_size=$(echo "scale=0;$size * 0.10 / 1" | bc)
nix_size=$(echo "scale=0;$size * 0.35 / 1" | bc)

# commence formatting
nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/install_pwd/disko.nix --arg device "\"/dev/$drive\"" --arg root_size "\"$root_size\G\"" --arg nix_size "\"$nix_size\G\"" 

mount /dev/disk/by-partlabel/disk-main-root /mnt
mkdir -p /mnt/nix && mount /dev/disk/by-partlabel/disk-main-nix /mnt/nix
mkdir -p /mnt/boot && mount /dev/disk/by-partlabel/disk-main-boot /mnt/boot
mkdir -p /mnt/home && mount /dev/disk/by-partlabel/disk-main-home /mnt/home 

# set up home directory in /mnt/persist, create /persist/etc/nixos, cd to /etc/nixos and install my flake config
mkdir -p /mnt/etc
cd /mnt/etc/
git clone https://github.com/pagedMov/pagedmov-nix-cfg.git ./nixos

nixos-install --root /mnt --flake /mnt/etc/nixos#mercury --no-root-password

echo
echo "Preliminary installation successful!"
echo "Beginning secondary installation phase... "
echo

cp -r /mnt/etc/nixos /mnt/home/pagedmov/.sysflake
chown -R pagedmov /mnt/home/pagedmov/.sysflake
rm -rf /mnt/etc/nixos
ln -s /mnt/home/pagedmov/.sysflake /etc/nixos

nixos-enter <<EOF
NIXOS_SWITCH_USE_DIRTY_ENV=1 nixos-rebuild boot --flake /home/pagedmov/.sysflake#mercury
EOF

echo "INSTALLATION COMPLETE ! !" | toilet -f 3d -w 120 | lolcat -a -s 180
echo "You can now reboot into your new system."
echo "The system configuration flake will be found in your home folder under .sysflake"
echo "/etc/nixos is a symlink leading to the .sysflake folder"
