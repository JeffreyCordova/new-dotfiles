#!/bin/sh
#     _            __        ____
#    (_)___  _____/ /_____ _/ / /
#   / / __ \/ ___/ __/ __ `/ / / 
#  / / / / (__  ) /_/ /_/ / / /  
# /_/_/ /_/____/\__/\__,_/_/_/   
#                                

BASE_PKGS=( git gtk julia npm nvim profile resources rofi scripts \
    templates termite tmux vscode zsh )
BSPWM_PKGS=( bspwm )
XMONAD_PKGS=( xmonad )

function refind_install() {
    sudo refind-install
    sudo cp -r refind/EFI/* /boot/
}

function reflector() {
    sudo pacman -S --noconfirm reflector
    sudo reflector --verbose \
                   --protocol https \
                   --latest 200 \
                   --sort rate \
                   --save /etc/pacman.d/mirrorlist
    sudo pacman -Syy
}

function trizen_install() {
    git clone https://aur.archlinux.org/trizen
    cd trizen
    makepkg -sri
    cd ..
    rm -rf trizen
}

function add_pgp_keys() {
    gpg --recv-keys 1EB2638FF56C0C53                            # pacaur
    gpg --recv-keys DBE7D3DD8C81D58D0A13D0E76BC26A17B9B7018A    # aurutils
}

function base_install() {

}
trizen -S --needed --noconfirm $(cat deps/base.deps)

PKGS=( bspwm compton dunst git gtk julia npm nvim polybar profile resources rofi \
    scripts sxhkd templates termite tmux vscode xorg xwinmosaic zsh )

for pkg in "${PKGS[@]}"; do
    stow $pkg
done

sudo npm install -g neovim
