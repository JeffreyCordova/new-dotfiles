#!/bin/sh
#     _            __        ____
#    (_)___  _____/ /_____ _/ / /
#   / / __ \/ ___/ __/ __ `/ / / 
#  / / / / (__  ) /_/ /_/ / / /  
# /_/_/ /_/____/\__/\__,_/_/_/   
#                                

sudo pacman -S $(cat deps/official.lst)
trizen -S --needed $(cat deps/aur.lst)

# stow
PKGS=( bspwm dunst git gtk julia npm nvim polybar profile resources \
    rofi scripts sxhkd templates termite tmux vscode xorg xwinmosaic zsh )

for pkg in "${PKGS[@]}"; do
    stow $pkg
done

#sudo npm install -g neovim
