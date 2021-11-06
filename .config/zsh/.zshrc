#### GENERAL CONFIG ####
fpath+=~/.zfunc

# Set some cool colors with wal if we can
[ $(command -v wal) ] && wal -R 1>/dev/null

# Configure zsh history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY

# Convient alieses
alias l='ls -lah'

eval "$(starship init zsh)"
eval "$(pyenv init -)"

# Configure Node Version Manager (NVM)
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#### FISH shell-like functionality ####
# Auto suggestion
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Substring search in zsh history
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

#### EMACS RELATED ####
# Add doom do the path
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

# Utility function for restarting polybar
export -f reset_polybar() {
   $HOME/.config/polybar/run.sh
}
