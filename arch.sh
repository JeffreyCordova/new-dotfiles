#!/bin/sh

timedatectl set-ntp true

parted /dev/sda mklabel msdos
parted /dev/sda mkpart primary ext4 0% 16GiB
parted /dev/sda mkpart primary linux-swap 16GiB 100%

mkfs.ext4 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2

mount /dev/sda1 /mnt
pacstrap -i /mnt base base-devel
genfstab -U -p /mnt >> /mnt/etc/fstab

cp chroot.sh /mnt/
arch-chroot /mnt ./chroot.sh
rm /mnt/chroot.sh

reboot
