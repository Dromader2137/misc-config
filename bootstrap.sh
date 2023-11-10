#!/bin/bash

mkdir .config

# Git & Rust
sudo pacman -S --needed --noconfirm git rustup
rustup default stable

# AUR Helper
sudo pacman -S --needed --noconfirm base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..

# Xorg
yay -S --noconfirm xorg xorg-xinit xorg-xrandr picom-git

# Tools
yay -S --noconfirm zip unzip dmenu npm librewolf-bin lazygit nvim-packer-git bluez bluez-utils
systemctl enable --now bluetooth.service

#WM
git clone https://github.com/leftwm/leftwm.git
cd leftwm
cargo build --profile optimized
sudo ln -s "$(pwd)"/target/optimized/leftwm /usr/bin/leftwm
sudo ln -s "$(pwd)"/target/optimized/leftwm-worker /usr/bin/leftwm-worker
sudo ln -s "$(pwd)"/target/optimized/lefthk-worker /usr/bin/lefthk-worker
sudo ln -s "$(pwd)"/target/optimized/leftwm-state /usr/bin/leftwm-state
sudo ln -s "$(pwd)"/target/optimized/leftwm-check /usr/bin/leftwm-check
sudo ln -s "$(pwd)"/target/optimized/leftwm-command /usr/bin/leftwm-command
cd ..
git clone https://github.com/Dromader2137/leftwm-config .config/leftwm/
cp -r leftwm/themes .config/leftwm
rm .config/leftwm/themes/README.md
ln -s .config/leftwm/themes/dr-theme .config/leftwm/themes/current

#Audio
yay -S --noconfirm pipewire pipewire-audio wireplumber pipewire-pulse
systemctl enable --now pipewire-pulse.service

#Text editors
yay -S --noconfirm neovim nvim-packer-git
git clone https://github.com/Dromader2137/nvim-config .config/nvim/
yay -S --noconfirm vim
yay -S --noconfirm nano
yay -S --noconfirm helix

#Terminal emulator
paru -S --noconfirm alacritty
git clone https://github.com/Dromader2137/alacritty-config .config/alacritty/

#Shell
git clone https://github.com/Dromader2137/fish-config .config/fish/
yay -S --noconfirm fish
cargo install starship
chsh -s /usr/bin/fish

#Misc
cargo install cargo-info
cargo install exa 
mv misc-config/.xinitrc .xinitrc

# Font
yay -S --noconfirm ttf-mononoki-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols-mono noto-fonts-emoji
