#!/bin/bash

mkdir .config
mkdir .config/nushell

# Git & Rust
sudo pacman -S --needed git rustup
rustup default stable

# AUR Helper
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..

# Xorg
paru -S xorg xorg-xinit picom-git

# Tools
paru -S neovim alacritty zip unzip dmenu npm floorp lazygit
git clone https://github.com/leftwm/leftwm.git
cd leftwm
cargo build --profile optimized
sudo ln -s "$(pwd)"/target/optimized/leftwm /usr/bin/leftwm
sudo ln -s "$(pwd)"/target/optimized/leftwm-worker /usr/bin/leftwm-worker
sudo ln -s "$(pwd)"/target/optimized/lefthk-worker /usr/bin/lefthk-worker
sudo ln -s "$(pwd)"/target/optimized/leftwm-state /usr/bin/leftwm-state
sudo ln -s "$(pwd)"/target/optimized/leftwm-check /usr/bin/leftwm-check
sudo ln -s "$(pwd)"/target/optimized/leftwm-command /usr/bin/leftwm-command
cd ../.config
git clone https://github.com/Dromader2137/nvim-config nvim/
git clone https://github.com/Dromader2137/alacritty-config alacritty/
git clone https://github.com/Dromader2137/leftwm-config leftwm/
git clone https://github.com/Dromader2137/nushell-config nushell/
cd ..
cp -r leftwm/themes .config/leftwm
rm .config/leftwm/themes/README.md
ln -s .config/leftwm/themes/basic_lemonbar .config/leftwm/themes/current
cargo install bat
cargo install du-dust
cargo install exa
cargo install wiki-tui
cargo install cargo-info

# Shell
cargo install nu
sudo cp .cargo/bin/nu /usr/bin/nu
sudo sh -c 'echo "/usr/bin/nu" >> /etc/shells'
chsh -s /usr/bin/nu

# Final
paru -S ttf-mononoki-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols-mono
git clone https://github.com/Dromader2137/misc-config
mv misc-config/.xinitrc .xinitrc

startx
