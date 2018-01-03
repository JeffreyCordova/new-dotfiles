#!/bin/sh

ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
hwclock --systohc
sed -i '/en_US/ s/^#//' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf

echo c137 > /etc/hostname
echo "127.0.1.1\tc137.localdomain\tc137" >> /etc/hosts

systemctl enable dhcpcd

pacman -S grub
grub-install /dev/sda
sed -i '/GRUB_CMDLINE_LINUX_DEFAULT/ s/^\(.*\)\("\)/\1 video=1920x1080\2/' \
    /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

sed -i '/Color/s/^#//' /etc/pacman.conf
sed -i '/\[multilib\]/,+1 s/^#//' /etc/pacman.conf
pacman -Syy

passwd

useradd -m -G wheel -s /bin/bash jeff
passwd jeff
visudo

exit
