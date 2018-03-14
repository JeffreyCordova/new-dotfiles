#!/bin/sh

function locale_config() {
    ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

    sed -i '0,/en_US.UTF-8/! {/en_US.UTF-8/ s/^#//}' /etc/locale.gen
    locale-gen

    echo LANG=en_US.UTF-8 > /etc/locale.conf

    hwclock --systohc
}

function host_config() {
    echo c137 > /etc/hostname
    echo "127.0.1.1\tc137.localdomain\tc137" >> /etc/hosts
}

function bootloader_install() {
    pacman -S --noconfirm git refind-efi intel-ucode wpa_supplicant dialog

    bootctl --path=/boot install

    curl -O https://raw.githubusercontent.com/JeffreyCordova/dotfiles/laptop/refind/loader/loader.conf
    curl -O https://raw.githubusercontent.com/JeffreyCordova/dotfiles/laptop/refind/loader/entries/arch.conf

    mv loader.conf /boot/loader/
    mv arch.conf /boot/loader/entries/
}

function pacman_config() {
    sed -i '/Color/s/^#//' /etc/pacman.conf
    sed -i '/\[multilib\]/,+1 s/^#//' /etc/pacman.conf

    pacman -Syy
}

function user_password_config() {
    passwd

    useradd -m -G wheel -s /bin/bash jeff
    passwd jeff

    visudo
}

function disable_beep() {
    echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
}

locale_config
host_config

bootloader_install
pacman_config
user_password_config

disable_beep

exit
