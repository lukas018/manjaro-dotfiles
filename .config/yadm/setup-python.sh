echo "Setup zsh"

# Install PYTHON related stuff
if [[ "$OS" == *"Arch"* || "$OS" == *"Manjaro"* ]]; then
    paru -S python3-pip --noconfirm
elif [[ "$OS" == *"Ubuntu"* ]]; then
    echo "Installing ubuntu python packages"
    sudo apt install python3-pip python3-venv -y
fi

# Some useful programs
yes | pip install pywal qtile

# Python package managers
pip install --user pipx
pipx install pdm

# poetry for easy project management
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -

# Install pyenv and use it to download a specific python version
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
zsh -ic "pyenv install 3.9.7 && pyenv global 3.9.7"
