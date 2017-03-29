#!/bin/sh
#
# installs all dotfiles through symlinks

echo "=-- Linking dotfiles! --="

CURRENT_PATH=$(pwd)

# Home directory
ln -si $CURRENT_PATH/home/.bashrc ~/.bashrc
ln -si $CURRENT_PATH/home/.zshrc ~/.zshrc
ln -si $CURRENT_PATH/home/.vimrc ~/.vimrc

# Atom
ln -si $CURRENT_PATH/home/.atom/config.cson ~/.atom/config.cson
ln -si $CURRENT_PATH/home/.atom/keymap.cson ~/.atom/keymap.cson

# Weechat
ln -si $CURRENT_PATH/home/.weechat ~/.weechat

echo "=-- Post install! --="
mkdir ~/.config
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
