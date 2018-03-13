#!/bin/sh

mount /dev/sda6 /mnt
mount /dev/sda2 /mnt/boot

cd /mnt/boot
rm refind_linux.conf vmlinuz-linux intel-ucode.img initramfs-linux.img initramfs-linux-fallback.img
rm -rf loader EFI/refind EFI/systemd
cd ..
umount /mnt/boot
rm -rf *
cd ~
umount /mnt

mkfs.ext4 /dev/sda6
mkswap /dev/sda7
swapon /dev/sda7

mount /dev/sda6 /mnt
mkdir -p /mnt/boot
mount /dev/sda2 /mnt/boot

pacman -Syy --noconfirm reflector
reflector --verbose \
          --protocol https \
          --latest 200 \
          --sort rate \
          --save /etc/pacman.d/mirrorlist
pacman -Syy

pacstrap /mnt base{,-devel}
genfstab -U -p /mnt >> /mnt/etc/fstab

curl -O https://raw.githubusercontent.com/JeffreyCordova/dotfiles/laptop/install/chroot.sh
chmod +x chroot.sh

cp chroot.sh /mnt/
arch-chroot /mnt ./chroot.sh
