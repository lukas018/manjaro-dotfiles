# Use powerline
USE_POWERLINE="false"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi

# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi


# Set all relevant aliases
alias config='git --git-dir $HOME/.cfg/ --work-tree=$HOME'
alias l='ls -lah'
export PATH=$PATH:$HOME/.emacs.d/bin/

export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
export PATH=/usr/local/texlive/2021/bin/x86_64-linux:$PATH

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# # shell configuration for emacs-vterm
vterm_printf(){
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ] ); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

vterm_cmd() {
    local vterm_elisp
    vterm_elisp=""
    while [ $# -gt 0 ]; do
        vterm_elisp="$vterm_elisp""$(printf '"%s" ' "$(printf "%s" "$1" | sed -e 's|\\|\\\\|g' -e 's|"|\\"|g')")"
        shift
    done
    vterm_printf "51;E$vterm_elisp"
}

vterm_set_directory() {
    vterm_cmd update-pwd "$PWD/"
}
# vterm_set_directory() {
#     vterm_cmd update-pwd "/-:""$USER""@""$HOSTNAME""#53000:""$PWD/"
# }

autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd (){ vterm_set_directory }

# Use the much nicer starship prompt
eval "$(starship init zsh)"
