#!/bin/bash


#
# Config Zsh, tmux
#

sudo apt-get update
sudo apt-get install -y zsh curl git vim tmux

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" 0</dev/null
mkdir ~/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


cp -r dot_files/. ~