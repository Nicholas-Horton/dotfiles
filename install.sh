#!/bin/sh
#
# installs all dotfiles through symlinks

echo "=-- Linking dotfiles! --="

CURRENT_PATH=$(pwd)

# Home directory
ln -si $CURRENT_PATH/home/.bashrc ~/.bashrc
ln -si $CURRENT_PATH/home/.zshrc ~/.zshrc
ln -si $CURRENT_PATH/home/.vimrc ~/.vimrc
ln -si $CURRENT_PATH/home/.gitconfig ~/.gitconfig
ln -si $CURRENT_PATH/home/.tmux.conf ~/.tmux.conf
ln -si $CURRENT_PATH/home/.xbindkeysrc ~/.xbindkeysrc

# Weechat
ln -si $CURRENT_PATH/home/.weechat ~/.weechat

echo "=-- Post install! --="
mkdir -p ~/.config

mkdir -p ~/.config/nvim
ln -si ~/.vimrc ~/.config/nvim/init.vim

mkdir -p ~/.config/rofi
mkdir -p ~/.config/alacritty
ln -si ~/git-workspace/dotfiles/home/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -si $CURRENT_PATH/home/.config/rofi/config ~/.config/rofi/config

