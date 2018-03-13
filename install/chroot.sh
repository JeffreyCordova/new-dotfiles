#!/bin/sh

ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
sed -i '0,/en_US.UTF-8/! {/en_US.UTF-8/ s/^#//}' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
hwclock --systohc

echo c137 > /etc/hostname
echo "127.0.1.1\tc137.localdomain\tc137" >> /etc/hosts

pacman -S --noconfirm refind-efi intel-ucode wpa_supplicant dialog
bootctl --path=/boot install
curl -O https://raw.githubusercontent.com/JeffreyCordova/dotfiles/laptop/refind/loader/loader.conf
curl -O https://raw.githubusercontent.com/JeffreyCordova/dotfiles/laptop/refind/loader/entries/arch.conf
mv loader.conf /boot/loader/
mv arch.conf /boot/loader/entries/

sed -i '/Color/s/^#//' /etc/pacman.conf
sed -i '/\[multilib\]/,+1 s/^#//' /etc/pacman.conf
pacman -Syy

pacman -S --noconfirm git

passwd

useradd -m -G wheel -s /bin/bash jeff
passwd jeff

visudo

echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf

exit
