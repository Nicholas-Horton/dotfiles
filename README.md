# Dotfiles
All of those sweet configuration files in one place, making setup infinitely
easier.
  * Automatically links all of the configuration files into your home directory
  * Make changes and easily push a commit when you see something you like!

# Usage
Clone the repository
```bash
git clone https://github.com/Nicholas-Horton/dotfiles.git
```

Run the installer!
```bash
cd dotfiles
./install.sh
```

Don't worry! If a configuration file already exists, the script will ask you if
you would like to overwrite it!

# Recommended Packages
In order to get my setup working correctly, it's recommended you install the
following packages:

## Core
```bash
pacman -S git zsh neovim tmux xbindkeys rofi fzf neofetch terminator pass
trizen -S rofi-pass
```

## Optional
```bash
pacman -S xfce4 pacaur weechat exa
trizen -S alacritty-git
```
