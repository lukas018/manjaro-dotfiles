# Get the current operating system
OS=$(uname -a)

# Installing Emacs
if [[ "$OS" == *"Ubuntu"* ]]; then
    sudo apt install libtool libtool-bin cmake -y # For building vterm in Emacs
    sudo apt install snapd -y
    sudo snap install emacs --classic
elif [[ "$OS" == *"Arch"* || "$OS" == *"MANJARO"* ]]; then
    sudo pacman -S cmake emacs --noconfirm
    # Install this with paru for conveniance    
    #paru -S libgccjit cmake --noconfirm
    # Here we need to edit the packagefile to enable JIT
    #mkdir repos
    #git clone https://aur.archlinux.org/emacs-git.git repos
    # Build emacs
    #cd repos/emacs-git && sed -i 's/JIT=/JIT="YES"/g' PKGBUILD && makepgk -si --noconfirm
fi

# Tangle our Emacs Config & install Doom Emacs
emacs --batch --eval "(progn (require 'org) (setq org-confirm-babel-evaluate nil) (org-babel-tangle-file \"~/.config/doom/config.org\"))"
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
yes |  bash $HOME/.config/doom/setup.sh
yes | ~/.emacs.d/bin/doom install

# Apply the current emacs theme to the entire system using wal
emacs --eval "(progn (theme-magic-from-emacs) (kill-emacs))" && cp ~/.cache/wal/colors.Xresources ~/.Xresources && xrdb ~/.Xresources
