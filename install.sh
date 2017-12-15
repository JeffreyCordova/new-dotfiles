#!/bin/sh
#     _            __        ____          __               
#    (_)___  _____/ /_____ _/ / /     ____/ /__  ____  _____
#   / / __ \/ ___/ __/ __ `/ / /_____/ __  / _ \/ __ \/ ___/
#  / / / / (__  ) /_/ /_/ / / /_____/ /_/ /  __/ /_/ (__  ) 
# /_/_/ /_/____/\__/\__,_/_/_/      \__,_/\___/ .___/____/  
#                                            /_/            

cmd="pacaur -S"
$cmd $(cat deps.lst)

# stow
PKGS=(bspwm compton dunst git gtk julia npm nvim polybar profile resources \
    rofi scripts sxhkd templates termite tmux vscode xorg xwinmosaic zsh)

for pkg in PKGS; do
    stow pkg
done

sudo npm install -g neovim
