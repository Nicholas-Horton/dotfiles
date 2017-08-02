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
ln -si $CURRENT_PATH/home/.fzf.zsh ~/.fzf.zsh
ln -si $CURRENT_PATH/home/.tmux.conf ~/.tmux.conf

# Atom
ln -si $CURRENT_PATH/home/.atom/config.cson ~/.atom/config.cson
ln -si $CURRENT_PATH/home/.atom/keymap.cson ~/.atom/keymap.cson

# Weechat
ln -si $CURRENT_PATH/home/.weechat ~/.weechat

echo "=-- Post install! --="
mkdir -p ~/.config

mkdir -p ~/.config/nvim
ln -si ~/.vimrc ~/.config/nvim/init.vim

mkdir -p ~/.config/rofi
ln -si $CURRENT_PATH/home/.config/rofi/config ~/.config/rofi/config

