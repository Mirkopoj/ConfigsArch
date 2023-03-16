#!/bin/sh

paru -S xorg xorg-xinit feh picom brave-bin alacritty btop calcurse dunst fish neofetch nvim qtile ranger rofi zathura pavucontrol exa bat openssh vimb zathura-pdf-poppler dash qalculate-gtk redshift betterlockscreen python-pip zip unzip ueberzug

pip install psutils

cp ~/.config/.xinitrc ~/.xinitrc
sudo ln -fs /bin/sh /bin/dash
