#!/bin/bash

# Update package database
sudo pacman -Syy

# Install Japanese fonts
echo "Installing Japanese fonts..."
sudo pacman -S noto-fonts-cjk

# Install input method engine
echo "Which input method engine do you want to install?"
echo "1. Anthy (default)"
echo "2. Mozc (Google Japanese Input)"
echo "Please enter your choice [1-2]: "
read input_method

# Check if a choice was entered, otherwise default to Anthy
if [[ $input_method == "" ]]; then
    input_method=1
    echo "No choice entered. Installing Anthy (default)..."
fi

# Install the chosen input method engine
case $input_method in
    1)
        echo "Installing Anthy..."
        sudo pacman -S fcitx-anthy
        ;;
    2)
        echo "Installing Mozc (Google Japanese Input)..."
        sudo pacman -S fcitx-mozc
        ;;
    *)
        echo "Invalid choice. Please choose a number between 1 and 2."
        exit 1
        ;;
esac

# Install fcitx configuration tool
echo "Installing fcitx configuration tool..."
sudo pacman -S fcitx-configtool

# Configure fcitx to start automatically
echo 'export GTK_IM_MODULE=fcitx' | sudo tee -a /etc/profile.d/fcitx.sh > /dev/null
echo 'export QT_IM_MODULE=fcitx' | sudo tee -a /etc/profile.d/fcitx.sh > /dev/null
echo 'export XMODIFIERS=@im=fcitx' | sudo tee -a /etc/profile.d/fcitx.sh > /dev/null

# Restart X server for changes to take effect
echo "Restarting display manager..."
sudo systemctl restart lightdm.service

echo "Japanese input method and fonts installation complete."
