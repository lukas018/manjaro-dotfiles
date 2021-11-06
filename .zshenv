[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME=$HOME/.config
[ -z "$XDG_CACHE_HOME" ] && export XDG_CACHE_HOME=$HOME/.cache
[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME=$HOME/.local/share

export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc

export ZDOTDIR=$XDG_CONFIG_HOME/zsh

# VIM Variables
export VIMDOTDIR=$XDG_CONFIG_HOME/vim 
export VIMRC=$VIMDOTDIR/vimrc
export VIMINIT="source $VIMRC"
export VIMINFO="source $VIMDOTDIR/viminfo"

export MPLAYER_HOME="$XDG_CONFIG_HOME"/mplayer

# Cargo for rush
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export PATH="$HOME/.cargo/bin:$PATH"

# Bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle

# NPM CONFIGURATIONS
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

# JUPYTER CONFIGURATIONS
export IPYTHONDIR="$XDG_CONFIG_HOME"/ipython
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export PYTHONPYCACHEPREFIX="$HOME/.cache/cpython/"
# ALIASES
alias='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts'

# Where to save GPG keys
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

# Default fonts
export FONT="JetBrains Mono"


export PATH=$HOME/.local/bin/:$PATH
export PATH="$HOME/.poetry/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
[ $(command -v pyenv) ] && eval "$(pyenv init --path)"

