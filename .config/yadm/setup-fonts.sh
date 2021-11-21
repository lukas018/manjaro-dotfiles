#!/usr/bin/zsh

# Get the current operating system
OS=$(uname -a)

# Prepare the necessary tools for Ubuntu
if [[ "$OS" == *"Ubuntu"^ ]]; then
	sudo apt update && sudo apt install unzip wget git curl apt-transport-https libtool libtool-bin -y
elif [[ "$OS" == *"Darwin"* ]]; then
	brew install unzip wget curl
fi


Set the installation directory for fonts
if [[ "$OS" == *"Darwin"* ]]; then
	FONT_LOCAL_DIR=~/Library/Fonts
elif [[ "$OS" == *"Ubuntu"* ]]; then
	FONT_LOCAL_DIR=~/.local/share/fonts
fi
    
# Create the user local fonts directory if needed 
mkdir -p $FONT_LOCAL_DIR

# INSTALL FONTS
# Alegreya
wget https://www.1001fonts.com/download/alegreya.zip -P $TMPDIR && cd $TMPDIR && unzip alegreya.zip -d alegreya && mv alegreya/*.ttf $FONT_LOCAL_DIR

# Merriweather
wget https://www.1001fonts.com/download/merriweather.zip -P $TMPDIR && cd $TMPDIR && unzip merriweather.zip -d merriweather && mv merriweather/*.ttf $FONT_LOCAL_DIR

# Fira Code
wget https://github.com/tonsky/FiraCode/releases/download/5.2/Fira_Code_v5.2.zip -P $TMPDIR && cd $TMPDIR && unzip Fira_Code_v5.2.zip && mv ttf/*.ttf $FONT_LOCAL_DIR

# Jetbrains Mono
cd $TMPDIR && wget https://download.jetbrains.com/fonts/JetBrainsMono-2.001.zip && unzip JetBrainsMono-2.001.zip && mv ttf/JetBrainsMono-*.ttf $FONT_LOCAL_DIR

# Overpass
wget https://github.com/RedHatOfficial/Overpass/releases/download/v3.0.5/overpass-3.0.5.zip -O $TMPDIR/overpass.zip && cd $TMPDIR && unzip overpass.zip && cd Overpass-3.0.5 && mv desktop-fonts/*/*.otf $FONT_LOCAL_DIR


# Julia Mono
wget https://github.com/cormullion/juliamono/releases/download/v0.043/JuliaMono.zip -O $TMPDIR/julia-mono.zip && cd $TMPDIR && mkdir -p julia-mono && unzip julia-mono.zip -d julia-mono && mv julia-mono/*.ttf $FONT_LOCAL_DIR

IMB-Flex-Plex
wget https://github.com/IBM/plex/releases/download/v6.0.0/OpenType.zip -O $TMPDIR/ibm-plex.zip && cd $TMPDIR && unzip ibm-plex.zip && mv OpenType/*/*otf $FONT_LOCAL_DIR
 

# Polybar and Rofi fonts

# SIJI
# Install dependencies
if [[ "$OS" == *"Ubuntu"* ]]; then
	sudo apt update
	sudo apt install x11-utils -y
elif [[ "$OS" == *"Arch"* || "$OS" == *"MANJARO"* ]]; then
	paru -S xorg-xfd --noconfirm
fi

# Install SIJI font

if [[ "$OS" == *"Ubuntu"* ]]; then
	git clone https://github.com/stark/siji /tmp/siji \
		&& cd /tmp/siji && sh install.sh -d $HOME/.local/share/fonts

elif [[ "$OS" == *"Arch"* || "$OS" == *"MANJARO"* ]]; then
	paru -S siji-git --noconfirm
fi

# FONT-AWESOME
if [[ "$OS" == *"Ubuntu"* ]]; then
	sudo apt update && sudo apt install -y fonts-font-awesome
elif [[ "$OS" == *"Arch"* || "$OS" == *"MANJARO"* ]]; then
	paru -S ttf-font-awesome --noconfirm
fi

# PAPER ICON
if [[ "$OS" == *"Ubuntu"* ]]; then
	yes \r | sudo add-apt-repository ppa:snwh/ppa && sudo apt update -y && sudo apt install paper-icon-theme -y
elif [[ "$OS" == *"Arch"* || "$OS" == *"MANJARO"* ]]; then
	paru -S paper-icon-theme --noconfirm
fi
