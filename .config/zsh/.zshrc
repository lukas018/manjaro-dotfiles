fpath+=~/.zfunc
# Use powerline
wal -R 1>/dev/null

# ZSH HISTORY
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY

# Emulated fish functionality
# fish-like auto suggestion
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# Enable substring search in zsh history
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Set all relevant aliases
alias config='git --git-dir $HOME/.cfg/ --work-tree=$HOME'
alias l='ls -lah'
export PATH=$PATH:$HOME/.emacs.d/bin/


## SHELL CONFIGURATION FOR EMACS-VTERM
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

autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd (){ vterm_set_directory }

# STARSHIP PROMPT
eval "$(starship init zsh)"

# CONFIGURATIONS FOR PYTHON
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"
export PATH="$HOME/.poetry/bin:$PATH"

# Configure Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
