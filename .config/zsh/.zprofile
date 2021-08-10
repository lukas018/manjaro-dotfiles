export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share

alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"

export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export ELINKS_CONFDIR="$XDG_CONFIG_HOME"/elinks
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export PATH="$HOME/.cargo/bin:$PATH"
export PYTHONPYCACHEPREFIX="$HOME/.cache/cpython/"

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx   # remove the exec to remain logged in when your wm ends
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
