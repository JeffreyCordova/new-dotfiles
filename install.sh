#!/bin/sh
#     _            __        ____
#    (_)___  _____/ /_____ _/ / /
#   / / __ \/ ___/ __/ __ `/ / / 
#  / / / / (__  ) /_/ /_/ / / /  
# /_/_/ /_/____/\__/\__,_/_/_/   
#                                

cmd="trizen -S"
$cmd $(cat deps.lst)

# stow
PKGS=(bspwm dunst git gtk julia npm nvim polybar profile resources \
    rofi scripts sxhkd templates termite tmux vscode xorg xwinmosaic zsh)

for pkg in PKGS; do
    stow $pkg
done

#sudo npm install -g neovim
