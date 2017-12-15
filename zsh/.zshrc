#              __             
#  ____  _____/ /_  __________
# /_  / / ___/ __ \/ ___/ ___/
#  / /_(__  ) / / / /  / /__  
# /___/____/_/ /_/_/   \___/  
#                             

#---[zplug loading]-------------------------------------------------------------
source /usr/share/zsh/scripts/zplug/init.zsh

#---[plugins]-------------------------------------------------------------------
MINIMAL_OK_COLOR=4

minimal_tmux_sessions() {
    local c="$MINIMAL_OK_COLOR"
    local fmt="\e[38;5;244m#{?session_attached,\e[0;3${c}m,} #S\e[0m"
    tmux list-sessions -F "$fmt" 2> /dev/null
}

minimal_magic_output() {
    local sessions="$(minimal_tmux_sessions)"
    if [ "$(echo $sessions | wc -l)" -gt 1 ]; then
        echo -n "[\e[38;5;244mtmux\e[0m -"
        minimal_tmux_sessions | tr -d '\n'
        echo "\e[0m]"
    fi
    minimal_magic_output_base
}

zplug "subnixr/minimal", use:minimal.zsh, from:github, as:theme
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
alias ls="ls --color=auto"
alias l="ls -lah"
alias grep="grep --color=auto"

#---[python]
alias ipy="ipython3 --no-confirm-exit"
alias pdb="python -m pdb"
alias mkvenv="mkvirtualenv"

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

#---[python venv wrapper]-------------------------------------------------------
venvwrap="/usr/bin/virtualenvwrapper_lazy.sh"
[ ! -e "$venvwrap" ] && venvwrap="/usr/local/bin/virtualenvwrapper_lazy.sh"
export WORKON_HOME="$HOME/.virtualenvs"
source "$venvwrap"
unset venvwrap

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
