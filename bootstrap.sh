#!/bin/bash

mkdir .config

# Git & Rust
sudo pacman -Syyu --needed --noconfirm git rustup go
rustup default stable

# AUR Helper
sudo pacman -S --needed --noconfirm base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..

# Xorg
yay -S --noconfirm xorg xorg-xinit xorg-xrandr picom

# Wayland
if [ $(lspci -k | grep "NVIDIA" | wc -l) = 2 ]; then
	yay -S --noconfirm hyprland-nvidia-git nvidia-open
else
	yay -S --noconfirm hyprland
fi
yay -S --noconfirm waybar-hyprland-git waylock swaybg

#Audio
yay -S --noconfirm pipewire pipewire-audio wireplumber pipewire-pulse pipewire-jack

# Tools
yay -S --noconfirm gum glow zip unzip dmenu dmwnu-wl npm floorp lazygit nvim-packer-git bluez bluez-utils cmake polybar pulsemixer bluetuith obs glow lxappearance nwg-look
systemctl enable --now bluetooth.service

#WM
git clone https://github.com/leftwm/leftwm.git
cd leftwm
cargo build --profile optimized
sudo ln -s "$(pwd)"/target/optimized/leftwm /usr/bin/leftwm
yay -S --noconfirm helix
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

git clone https://github.com/Dromader2137/hyprland-config .config/hypr/
git clone https://github.com/Dromader2137/waybar-config .config/waybar/

#Text editors
yay -S --noconfirm neovim nvim-packer-git
git clone https://github.com/Dromader2137/nvim-config .config/nvim/

#Terminal emulator
paru -S --noconfirm alacritty
git clone https://github.com/Dromader2137/alacritty-config .config/alacritty/

#Shell
git clone https://github.com/Dromader2137/fish-config .config/fish/
yay -S --noconfirm fish starship
chsh -s /usr/bin/fish

#Misc
cargo install exa 
mv misc-config/.xinitrc .xinitrc
mv misc-config/.Xresources .Xresources
mv misc-config/.gtkrc-2.0 .gtkrc-2.0
mkdir .config/gtk-3.0
mv misc-config/settings.ini .config/gtk-3.0

# Font
yay -S --noconfirm ttf-mononoki-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols-mono noto-fonts-emoji
yay -S --noconfirm gruvbox-dark-gtk gruvbox-dark-icons-gtk xcursor-simp1e-gruvbox-dark

rm -rf misc-config/ yay/ .bashrc .bash_profile .bash_history .bash_logout
