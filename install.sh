#!/bin/sh
#     _            __        ____
#    (_)___  _____/ /_____ _/ / /
#   / / __ \/ ___/ __/ __ `/ / / 
#  / / / / (__  ) /_/ /_/ / / /  
# /_/_/ /_/____/\__/\__,_/_/_/   
#                                

sudo pacman -S --noconfirm reflector
sudo reflector --verbose --protocol https \
                         -l 200 \
                         --sort rate \
                         --save /etc/pacman.d/mirrorlist
sudo pacman -Syy

git clone https://aur.archlinux.org/trizen
cd trizen
makepkg -sri
cd ..
rm -rf trizen

sudo pacman -S --noconfirm $(cat deps/official.lst)
trizen -S --needed --noconfirm $(cat deps/aur.lst)

chsh -s /usr/bin/zsh

# stow
PKGS=( bspwm dunst git gtk julia npm nvim polybar profile resources rofi \
    scripts sxhkd templates termite tmux vscode xorg xwinmosaic zsh )

for pkg in "${PKGS[@]}"; do
    stow $pkg
done

sudo npm install -g neovim

sh -c "$(curl -fsSL https://raw.githubusercontent.com/illinoisjackson/even-better-ls/master/install.sh)"
rm -rf coreutils-8.2

#FONTS=( Bold Light Medium )
#cd /usr/share/fonts/OTF
#for font in "${FONTS[@]}"; do
#    sudo curl -O https://raw.githubusercontent.com/ryanoasis/nerd-fonts/patched-fonts/Hermit/$font/complete/Hurmit\ $font\ Nerd\ Font\ Complete.otf
#    sudo curl -O https://raw.githubusercontent.com/ryanoasis/nerd-fonts/patched-fonts/Hermit/$font/complete/Hurmit\ $font\ Nerd\ Font\ Complete\ Mono.otf
#done

#cd ~/dotfiles
