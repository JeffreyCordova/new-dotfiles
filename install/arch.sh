#!/bin/sh

function mount_partitions() {
    mount /dev/sda6 /mnt
    if [ ! -d "/mnt/boot" ]; then
        mkdir -p /mnt/boot
    fi
    mount /dev/sda2 /mnt/boot
}

function clean_partitions() {
    cd /mnt/boot
    rm refind_linux.conf vmlinuz-linux intel-ucode.img initramfs-linux.img initramfs-linux-fallback.img
    rm -rf loader EFI/refind EFI/systemd
    cd ..
    umount /mnt/boot
    rm -rf *
    cd ~
    umount /mnt
}

function format_partitions() {
    mkfs.ext4 /dev/sda6
    mkswap /dev/sda7
    swapon /dev/sda7
}

function run_reflector() {
    pacman -Syy --noconfirm reflector
    reflector --verbose \
              --protocol https \
              --latest 200 \
              --sort rate \
              --save /etc/pacman.d/mirrorlist
    pacman -Syy
}

function arch_install() {
    pacstrap /mnt base{,-devel}
    genfstab -U -p /mnt >> /mnt/etc/fstab
}

mount_partitions
clean_partitions
mount_partitions
format_partitions

run_reflector
arch_install

#curl -O https://raw.githubusercontent.com/JeffreyCordova/dotfiles/laptop/install/chroot.sh
#chmod +x chroot.sh

cp chroot.sh /mnt/
arch-chroot /mnt ./chroot.sh
