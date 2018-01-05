#              __             
#  ____  _____/ /_  __________
# /_  / / ___/ __ \/ ___/ ___/
#  / /_(__  ) / / / /  / /__  
# /___/____/_/ /_/_/   \___/  
#                             

#---[zplug loading]-------------------------------------------------------------
source /usr/share/zsh/scripts/zplug/init.zsh

#---[plugins]-------------------------------------------------------------------
zplug "denysdovhan/spaceship-zsh-theme", use:spaceship.zsh, from:github, as:theme
zplug "zsh-users/zsh-syntax-highlighting", defer:2

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

#---[no history duplicates]-----------------------------------------------------
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

#---[case-insensitive completion]-----------------------------------------------
zstyle ':completion:*' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

#---[vi mode]-------------------------------------------------------------------

bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history

bindkey '^?' backward-delete-char

bindkey '^r' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-backward
bindkey -M vicmd 'j' history-beginning-search-forward
bindkey -M vicmd 'k' history-beginning-search-backward

bindkey -M vicmd 'K' run-help

export KEYTIMEOUT=1

#---[aliases]-------------------------------------------------------------------
#alias ls="ls --color=auto"
alias l="ls -lah"
alias grep="grep --color=auto"

#---[PATH]
alias path='printf "${PATH//:/\\n}\n"'

#---[tmux]
alias tmuxk="tmux kill-session -t"
alias tmuxl="tmux list-session -F #S"
alias tmuxn="tmuxd -n"
alias tmuxa="tmuxd -a"

alias shutdown="shutdown -h now"

alias reflector="sudo reflector --verbose \
                                --protocol https \
                                -l 200 \
                                --sort rate \
                                --save /etc/pacman.d/mirrorlist"

alias pkg-list="comm -23 <(pacaur -Qqt | sort) \
                   <(pacaur -Sqg base base-devel | sort) \
                   > pkgs.lst"

#---[tmux environment refresh]--------------------------------------------------

if [ -n "$TMUX" ]; then
    function tmux_refresh_env() {
        eval $(tmux show-environment -s)
    }
else
    function tmux_refresh_env() {
        true
    }
fi

function preexec() {
    tmux_refresh_env
}

LS_COLORS=$(ls_colors_generator)

run_ls() {
    ls-i --color=auto -w $(tput cols) "$@"
}

run_dir() {
    dir-i --color=auto -w $(tput cols) "$@"
}

run_vdir() {
    vdir-i --color=auto -w $(tput cols) "$@"
}

alias ls="run_ls"
alias dir="run_dir"
alias vdir="run_vdir"

#---[spaceship theme settings]--------------------------------------------------

#---[directory]
SPACESHIP_DIR_TRUNC=0

#---[battery]
SPACESHIP_BATTERY_SHOW=false

#---[vi mode]
spaceship_vi_mode_enable
