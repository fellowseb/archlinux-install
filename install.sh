# See:
# - https://wiki.archlinux.org/index.php/Installation_guide

# Set keyboard layout (French AZERTY keyboard)
loadkeys fr-latin1

# Set time zone.
# Handy if working inside a VM
timedatectl set-timezone Europe/Paris

# Update system clock
timedatectl set-ntp true

# Identify target device
lsblk
#=> /dev/sdX or /dev/nvmenX
# Check existing partitions
gdisk -l /dev/sdX
# Enter partitions edition mode
gdisk /dev/sdX
# Create partitions
# If necessary, create EFI partition
# Command: n
# Partion number: 1
# First sector: 2048 (default)
# Last sector: +550M
# Partition type: EF00
#
# Create arch root partition:
# Command: n
# Partion number: 2
# First sector: (default)
# Last sector: +50G
# Partition type: 8300
#
# Create Shared Data (NTFS) partition:
# Command: n
# Partion number: 3
# First sector: (default)
# Last sector: (default)
# Partition type: 0700
#
# Change parition labels (names)
# Command: c
# Partition number: 2
# Name: Arch Linux
# (Repeat)
#
# Save and quit
# Command: w
# y

# /dev/zero > /dev/sdXY
# shred -z /dev/sdXY

# Check new partitions and locate Arch linux partition sdXY
lsblk
# fdisk -l /dev/sdX

# Set up encryption container with dm-crypt + LUKS
cryptsetup luksFormat /dev/sdXY
# YES
# Passphrase: ******
# Open container and call it lukscontainer:
cryptsetup luksOpen /dev/sdXY lukscontainer

# Create LVM physical volume (PV)
pvcreate /dev/mapper/lukscontainer
# Create LVM volume group
vgcreate lvmg /dev/mapper/lukscontainer
# Create LVM logical volumes (swap and root).
# Maybe, leave some space in the group for later extensions
lvcreate -L 8G lvmg -n swap
lvcreate -l 100%FREE lvmg -n root

# Format
# if needed (EFI):
mkfs.vfat -F32 /dev/sda[EFI]
mkfs.btrfs -L btrfs /dev/mapper/lvmg-root
mkswap /dev/mapper/lvmg-swap
swapon /dev/mapper/lvmg-swap

# Create BTRFS subvolumes
mount /dev/mapper/lvmg-root /mnt
mkdir /mnt/{_active,_snapshots}
btrfs subvolume create /mnt/_active/root
btrfs subvolume create /mnt/_active/home
umount /mnt
mount -o subvol=_active/root,ssd /dev/mapper/lvmvg-root /mnt
mkdir -p /mnt/{boot,home,esp}
mount -o subvol=_active/home,ssd /dev/mapper/lvmvg-root /mnt/home

mount /dev/sda[EFI] /mnt/esp
mkdir -p /mnt/esp/EFI/arch
mount -B /mnt/esp/EFI/arch /mnt/boot
# Optional: edit /etc/pacman.d/mirrorlist file

# Install packages
pacstrap /mnt base base-devel efibootmgr refind-efi openssl btrfs-progs sbsigntools intel-ucode terminus-font
# for wifi: wpa_supplicant dialog

# Generate fstab
genfstab -UP /mnt > /mnt/etc/fstab
nano /mnt/etc/fstab
# Modify /mnt/esp/EFI/arch line to:
# /esp/EFI/arch     /boot       none        defaults,bind 0 0

# Enter new system
arch-chroot /mnt /bin/bash

# Network config
echo thinkmachine > /etc/hostname
# Edit /etc/hosts to add:
# 127.0.0.1 localhost
# ::1       localhost
#127.0.1.1  thinkmachine.localdomain thinkmachine
nano /etc/hosts

# Choose correct timezone
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc

# Uncomment fr_FR and en_GB locales
nano /etc/locale.gen
locale-gen
echo LANG=en_GB.UTF-8 >> /etc/locale.conf
echo KEYMAP=fr-latin1 >> /etc/vconsole.conf
echo FONT=term-132n >> /etc/vconsole.conf

passwd
useradd -m -G wheel -s /bin/bash seb
passwd seb
nano /etc/sudoers
# Uncomment wheel group line

# Edit mkinitcpio.conf HOOKS
nano /etc/mkinitcpio.conf
# HOOKS=(... keyboard consolefont keymap encrypt lvm2 btrfs filesystems ...)

mkinitcpio -p linux

# Enable multi core pkg build and compression
nano /etc/makepkg.conf
#COMPRESSXZ=(xz -c -z - --threads=0)
#MAKEFLAGS="-j$(nproc)"

# Get and install yay (AUR Helper)
su seb
cd
mkdir builds
cd builds
curl -L -0 https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz > yay.tar.gz
tar zxvf yay.tar.gz
cd yay
makepkg -si

# Get and install shim
# su seb
# mkdir builds
# curl -L -0 https://aur.archlinux.org/cgit/shim-signed.tar.gz > shim-signed.tar.gz
# tar zxvf shim-signed.tar.gz
# cd shim-signed
# makepkg -si

yay -S shim-signed
exit

# Temporarily monut ESP to /boot
umount -R /boot
mount /dev/sda1 /boot

# install refind
# sometimes its shimx64.efi
refind-install --shim /usr/share/shim-signed/shim.efi --localkeys

sbsign --key /etc/refind.d/keys/refind_local.key --cert /etc/refind.d/keys/refind_local.crt --output /boot/EFI/arch/vmlinuz-linux /boot/EFI/arch/vmlinuz-linux

# Write HOOK to sign kernel each time its upgraded/installed/removed
nano /etc/pacman.d/hooks/99-secureboot.hook
# [Trigger]
# Operation = Install
# Operation = Upgrade
# Type = Package
# Target = linux
#
# [Action]
# Description = Signing Kernel for SecureBoot
# When = PostTransaction
# Exec = /usr/bin/sbsign --key /etc/refind.d/keys/refind_local.key --cert /etc/refind.d/keys/refind_local.crt --output /boot/vmlinuz-linux /boot/vmlinuz-linux
# Depends = sbsigntools

nano /boot/EFI/refind/refind.conf
# Uncomment include manual.conf
nano /boot/EFI/refind/manual.conf
# menuentry "Arch Linux" {
#   icon    /EFI/refind/icons/os_arch.png
#   loader  /EFI/arch/vmlinuz-linux
#   options "cryptdevice=/dev/sda2:lukscontainer ro root=/dev/mapper/lvmg-root rootflags=subvol=_active/root,ssd initrd=/EFI/arch/intel-ucode.img initrd=/EFI/arch/initramfs-linux.img"
#   submenuentry "Boot using fallback initramfs" {
#       options "cryptdevice=/dev/sda2:lukscontainer ro root=/dev/mapper/lvmg-root initrd=/EFI/arch/intel-ucode.img initrd=/EFI/arch/initramfs-linux-fallback.img"
#   }
#   submenuentry "Boot to terminal" {
#       add_options "systemd.unit=multi-user.target"
#   }
# }

# Install utilities
pacman -S gvim gpg2 chromium tlp wget unzip

# Install Xorg
pacman -S xorg xterm xorg-xrandr
localectl --no-convert set-x11-keymap fr

# Install WM
su seb
yay -S awesome
cp /etc/xdg/awesome/ ~/.config/awesome/
echo "exec awesome" >> ~/.xinitrc
exit

# Install DM
pacman -S lightdm lightdm-gtk-greeter
systemctl enable lightdm.service

# Install iGPU drivers
pacman -S xf86-video-intel #xf86-video-fbdev under VM
# Install dGPU drivers (native NVIDIA)
curl -L -0 https://cfnvidiawebsitetogetlinux64runfile > /home/seb/Downloads/thefile.run
sh /home/seb/Downloads/thefile.run # xserver needs to be exited
# Install bumblebee
pacman -S bumblebee mesa bbswitch
g passwd -a seb bumblebee
systemctl enable bumblebeed.service
# Test it
pacman -S mesa-demos
optirun glxspheres64

# Install smart card reader utilities
pacman -S ccid opensc
systemctl enable pcscd.enable

# Done!
exit

umount -R /mnt
swapoff -a

reboot

# Dynamically acquire IP on eth0
dhcpcd eth0

# Generate an effective list of mirrors
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
rankmirrors -n 6 /etc/pacman.d/mirrorlist.bak > /etc/pacman.d/mirrorlist
