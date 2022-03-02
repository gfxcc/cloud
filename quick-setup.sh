#!/bin/bash


#
# Config Zsh, tmux
#

apt-get update
apt-get install -y zsh curl git vim

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mkdir ~/.zsh

rm -rf /tmp/cloud
git clone https://github.com/gfxcc/cloud.git /tmp/cloud

cp -r /tmp/cloud/dot_files/. ~