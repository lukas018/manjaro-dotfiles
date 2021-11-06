#!/usr/bin/zsh
OS=$(uname -a)

function install_brave_deb {
	sudo apt install apt-transport-https curl -y
	sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

	echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

	sudo apt update
	sudo apt install brave-browser -y
}

# List of common apps that can be downloaded directly
APPS="flameshot bspwm xmonad feh htop docker docker-compose"

if [[ "$OS" == *"Ubuntu"* ]]; then
	sudo apt install $(echo $APPS) -y
	install_brave_deb
	sudo apt install texlive-latex-extra -y
elif [[ "$OS" == *"Arch"* || "$OS" == *"Manjaro"* ]]; then
	paru -S brave $(echo $APPS) --noconfirm
	paru -S texlive-most tllocalmgr-git --noconfirm
fi
