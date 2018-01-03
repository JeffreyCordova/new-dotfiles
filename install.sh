#!/bin/sh
#     _            __        ____
#    (_)___  _____/ /_____ _/ / /
#   / / __ \/ ___/ __/ __ `/ / / 
#  / / / / (__  ) /_/ /_/ / / /  
# /_/_/ /_/____/\__/\__,_/_/_/   
#                                

sudo pacman -S virtualbox-guest-utils virtualbox-guest-modules-arch
sudo systemctl enable vboxservice

sudo pacman -S git reflector
sudo reflector --verbose --protocol https -l 200 --sort rate --save /etc/pacman.d/mirrorlist

git clone https://aur.archlinux.org/trizen
cd trizen
makepkg -sri
cd ..
rm -rf trizen

sudo pacman -S $(cat deps/official.lst)
trizen -S --needed --noconfirm $(cat deps/aur.lst)

chsh -s /usr/bin/zsh

# stow
PKGS=( bspwm dunst git gtk julia npm nvim polybar profile resources rofi \
    scripts sxhkd templates termite tmux vscode xorg xwinmosaic zsh )

for pkg in "${PKGS[@]}"; do
    stow $pkg
done

sudo npm install -g neovim
gem install neovim

sh -c "$(curl -fsSL https://raw.githubusercontent.com/illinoisjackson/even-better-ls/master/install.sh)"
rm -rf coreutils-8.2
