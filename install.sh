#!/bin/sh
#     _            __        ____
#    (_)___  _____/ /_____ _/ / /
#   / / __ \/ ___/ __/ __ `/ / / 
#  / / / / (__  ) /_/ /_/ / / /  
# /_/_/ /_/____/\__/\__,_/_/_/   
#                                

platform=$1
opt=$2

sudo refind-install
sudo cp -r refind/EFI/* /boot/

sudo pacman -S --noconfirm reflector
sudo reflector --verbose \
               --protocol https \
               --latest 200 \
               --sort rate \
               --save /etc/pacman.d/mirrorlist
sudo pacman -Syy

git clone https://aur.archlinux.org/trizen
cd trizen
makepkg -sri
cd ..
rm -rf trizen

gpg --recv-keys 1EB2638FF56C0C53                            # pacaur
gpg --recv-keys DBE7D3DD8C81D58D0A13D0E76BC26A17B9B7018A    # aurutils

trizen -S --needed --noconfirm $(cat deps/base.deps)

if [ "$platform" == "desktop" ]; then
    trizen -S --needed --noconfirm $(cat deps/desktop.deps)
elif [ "$platform" == "laptop" ]; then
    trizen -S --needed --noconfirm $(cat deps/laptop.deps)
fi

if [ "$opt" == "bspwm" ]; then
    trizen -S --needed --noconfirm $(cat deps/bspwm.deps)
elif [ "$opt" == "xmonad" ]; then
    trizen -S --needed --noconfirm $(cat deps/xmonad.deps)
fi

chsh -s /usr/bin/zsh

PKGS=( bspwm compton dunst git gtk julia npm nvim polybar profile resources rofi \
    scripts sxhkd templates termite tmux vscode xorg xwinmosaic zsh )

for pkg in "${PKGS[@]}"; do
    stow $pkg
done

sudo npm install -g neovim
