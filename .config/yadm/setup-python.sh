#!/usr/bin/zsh
echo "Setup python and node"

# Get the current operating system
OS=$(uname -a)

# Install PYTHON related stuff
if [[ "$OS" == *"Ubuntu"*  || "$OS" == *"Microsoft"* ]]; then
    echo "Installing ubuntu python packages"
    sudo apt update
    sudo apt install python3-pip python3-venv -y
    sudo apt install make build-essential libssl-dev zlib1g-dev \
	libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
	libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev -y
elif [[ "$OS" == *"Arch"* || "$OS" == *"MANJARO"* ]]; then
    paru -S --needed python-pip base-devel openssl zlib xz --noconfirm
elif [[ "$OS" == *"Darwin"* ]]; then
    brew install python # This installs pip as well
    brew install openssl readline sqlite3 xz zlib
    alias pip=pip3
fi


# Install pyenv and use it to download a specific python version
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

# Reload the configurations
function source_zsh_config {
	ZSH_PATH=$HOME/.config/zsh
	source $HOME/.zshenv && source $ZSH_PATH/.zprofile && source $ZSH_PATH/.zshrc
}

# Reload the configurations completely
source_zsh_config

# Install a new python environment
pyenv install 3.9.7 && pyenv global 3.9.7

# Update pip
pip install pip --upgrade

# Some useful programs
yes | pip install pywal

# Python package managers
yes | pip install --user pipx && pipx install pdm

# Poetry for easy project management
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python3 -


# Install node package manager
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | zsh
source_zsh_config
nvm install node
