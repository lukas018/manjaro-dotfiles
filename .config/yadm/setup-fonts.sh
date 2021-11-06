#!/usr/bin/zsh

# Get the current operating system
OS=$(uname -a)

# Prepare the necessary tools
sudo apt update && sudo apt install unzip wget git curl apt-transport-https libtool libtool-bin -y

# Create the user local fonts directory if needed 
mkdir -p $HOME/.local/share/fonts

# INSTALL FONTS
# Alegreya
wget https://www.1001fonts.com/download/alegreya.zip -P /tmp && cd /tmp && unzip alegreya.zip -d alegreya && mv alegreya/*.ttf ~/.local/share/fonts

# Fira Code
wget https://github.com/tonsky/FiraCode/releases/download/5.2/Fira_Code_v5.2.zip -P /tmp && cd /tmp && unzip Fira_Code_v5.2.zip && mv ttf/*.ttf ~/.local/share/fonts

# Jetbrains Mono
cd /tmp && wget https://download.jetbrains.com/fonts/JetBrainsMono-2.001.zip && unzip JetBrainsMono-2.001.zip && mv ttf/JetBrainsMono-*.ttf ~/.local/share/fonts/

# Overpass
wget https://github.com/RedHatOfficial/Overpass/releases/download/v3.0.5/overpass-3.0.5.zip -O /tmp/overpass.zip && cd /tmp && unzip overpass.zip && cd Overpass-3.0.5 && mv desktop-fonts/*/*.otf ~/.local/share/fonts


# Julia Mono
wget https://github.com/cormullion/juliamono/releases/download/v0.043/JuliaMono.zip -O /tmp/julia-mono.zip && cd /tmp && mkdir -p julia-mono && unzip julia-mono.zip -d julia-mono && mv julia-mono/*.ttf ~/.local/share/fonts


#IMB-Flex-Plex
wget https://github.com/IBM/plex/releases/download/v6.0.0/OpenType.zip -O /tmp/ibm-plex.zip && cd /tmp && unzip ibm-plex.zip && mv OpenType/*/*otf ~/.local/share/fonts
 

# Merriweather
echo "Installing Merriweather font... this may take a while"
git clone https://github.com/SorkinType/Merriweather.git /tmp/Merriweather && cd /tmp/Merriweather && mv fonts/*/*.ttf ~/.local/share/fonts

# SIJI
# Install dependencies
if [[ "$OS" == *"Ubuntu"* ]]; then
	sudo apt update
	sudo apt install x11-utils -y
elif [[ "$OS" == *"Arch"* || "$OS" == *"Manjaro"* ]]; then
	sudo paru -S xorg-xfd	--noconfirm
fi

# Install siji font
git clone https://github.com/stark/siji /tmp/siji && cd /tmp/siji && sh install.sh

# Font-awesome
if [[ "$OS" == *"Ubuntu"* ]]; then
	sudo apt update && sudo apt install -y fonts-font-awesome
elif [[ "$OS" == *"Arch"* || "$OS" == *"Manjaro"* ]]; then
	sudo paru -S ttf-font-awesome --noconfirm
fi

# Paper Icon
if [[ "$OS" == *"Ubuntu"* ]]; then
	yes \r | sudo add-apt-repository ppa:snwh/ppa && sudo apt update -y && sudo apt install paper-icon-theme -y
elif [[ "$OS" == *"Arch"* || "$OS" == *"Manjaro"* ]]; then
	sudo paru -S paper-icon-theme --noconfirm
fi
