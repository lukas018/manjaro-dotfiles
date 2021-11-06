#!/usr/bin/zsh
OS=$(uname -a)

function install_brave_deb {
	sudo apt install apt-transport-https curl -y
	sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

	echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

	sudo apt update
	sudo apt install brave-browser -y
}

function install_polybar_deb {
	sudo apt-get install -y cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python3-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libxcb-composite0-dev libjsoncpp-dev python3-sphinx  python3-xcbgen
	sudo ln -s /usr/include/jsoncpp/json/ /usr/include/json
	mkdir -p repos 
	git clone https://github.com/jaagr/polybar.git repos/polybar
	# We need to use the system installation to build so lets save the current version
	python_version=$(pyenv version-name)
	cd repos/polybar && pyenv global system && yes | ./build.sh
	pyenv global $python_version
}


# List of common apps that can be downloaded directly
APPS="flameshot bspwm xmonad feh htop docker docker-compose"

if [[ "$OS" == *"Ubuntu"* ]]; then
	sudo apt install $(echo $APPS) -y
	install_brave_deb
	install_polybar_deb
	sudo apt install texlive-latex-extra -y
elif [[ "$OS" == *"Arch"* || "$OS" == *"Manjaro"* ]]; then
	paru -S brave polybar $(echo $APPS) --noconfirm
	paru -S texlive-most tllocalmgr-git --noconfirm
fi
