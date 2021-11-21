#!/usr/bin/zsh
OS=$(uname -a)

function install_brave_deb {
	# Installation tools
	sudo apt install apt-transport-https curl -y

	# Add brave gpg key
	brave-keyring="https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg"
	sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg $brave-keyring

	# Add brave *ppa* to sources list
	echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" \
		| sudo tee /etc/apt/sources.list.d/brave-browser-release.list

	# Install brave
	sudo apt update
	sudo apt install brave-browser -y
}

function install_polybar_deb {
	# Dependencies
	sudo apt-get install -y cmake cmake-data libcairo2-dev libxcb1-dev \
		libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev \
		libxcb-util0-dev libxcb-xkb-dev pkg-config python3-xcbgen xcb-proto \
		libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev \
		libcurl4-openssl-dev libpulse-dev libxcb-composite0-dev \
		libjsoncpp-dev python3-sphinx  python3-xcbgen libuv1-dev

	sudo ln -s /usr/include/jsoncpp/json/ /usr/include/json
	mkdir -p repos 
	git clone https://github.com/jaagr/polybar.git repos/polybar

	# We need to use the system python version to build so we save the current version and switch
	python_version=$(pyenv version-name)
	cd repos/polybar && pyenv global system && yes | ./build.sh
	pyenv global $python_version # Go back to our old setting
}

function install_alacritty_deb {
	# Add alacritty ppa
	yes "\r" | sudo add-apt-repository ppa:aslatter/ppa
	sudo apt update
	sudo apt install alacritty -y
}

function install_picom_deb {

	# Required build tools
	sudo apt install -y python3 python3-pip \
		python3-setuptools python3-wheel \
			ninja-build build-essential

	# Picom dependencies
	sudo apt install -y libxext-dev libxcb1-dev \
		libxcb-damage0-dev libxcb-xfixes0-dev \
		libxcb-shape0-dev libxcb-render-util0-dev \
		libxcb-render0-dev libxcb-randr0-dev \
		libxcb-composite0-dev libxcb-image0-dev \
		libxcb-present-dev libxcb-xinerama0-dev \
		libxcb-glx0-dev libpixman-1-dev libdbus-1-dev \
		libconfig-dev libgl1-mesa-dev \
		libpcre2-dev  libevdev-dev uthash-dev \
		libev-dev libx11-xcb-dev asciidoc

	# CLone and build
	git clone https://github.com/sandsmark/picom.git ~/repos/picom && \
		cd ~/repos/picom && \
		git submodule update --init --recursive && \
		meson --buildtype=release . build && \
		ninja -C build
}


function install_docker_deb {
	# Install docker
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"
	sudo apt update
	sudo apt install docker-ce -y

	# Start the docker service
	sudo systemctl start docker
	sudo systemctl enable docker

	# Prevents permission denied error while connecting to docker daemon socket
	sudo chmod 666 /var/run/docker.sock
	sudo usermod -aG docker ${USER}

	# Install docker compose
	sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
}

# List of common apps that can be downloaded directly
APPS="flameshot feh htop docker docker-compose rofi ripgrep"

if [[ "$OS" == *"Ubuntu"* ]]; then
	sudo apt install $(echo $APPS) -y
	install_brave_deb
	install_polybar_deb
	install_alacritty_deb
	install_picom_deb
	sudo apt install texlive-latex-extra -y
	sudo apt bspwm
elif [[ "$OS" == *"Arch"* || "$OS" == *"MANJARO"* ]]; then
	ARCH_APPS="brave polybar alacritty picom"
	paru -S $(echo $ARCH_APPS) $(echo $APPS) --noconfirm
	paru -S sxhkd --noconfirm # need to install this separetly from bspwm on arch
	paru -S texlive-most tllocalmgr-git --noconfirm
	paru -S bspwm-rounded-corners-git # Who doesn't love rounded corners
fi

# This is needed to enable siji fonts in polybar for some reason
NO_BITMAP_FILE=/etc/fonts/conf.d/70-no-bitmaps.conf
[ -f $NO_BITMAP_FILE ] && sudo rm $NO_BITMAP_FILE
