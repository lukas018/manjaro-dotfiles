echo "Setup zsh"

# Get the current operating system
OS=$(uname -a)

# Install PYTHON related stuff
if [[ "$OS" == *"Ubuntu"* ]]; then
    echo "Installing ubuntu python packages"
    sudo apt update
    sudo apt install python3-pip python3-venv -y
    sudo apt install make build-essential libssl-dev zlib1g-dev \
	libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
	libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev -y
elif [[ "$OS" == *"Arch"* || "$OS" == *"Manjaro"* ]]; then
    paru -S --needed python3-pip base-devel openssl zlib xz --noconfirm
fi


# Install pyenv and use it to download a specific python version
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
zsh -ic "source $HOME/.config/zsh/.zprofile && pyenv install 3.9.7 && pyenv global 3.9.7"

# Some useful programs
zsh -ic "yes | pip install pywal qtile"

# Python package managers
zsh -ic "yes | pip install --user pipx && pipx install pdm"

# Poetry for easy project management
zsh -ic "curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python3 -"
