export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
. "$HOME/.cargo/env"

# Reload the Xresources file
xrdb $HOME/.Xresources
