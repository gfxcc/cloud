#!/bin/bash


#
# Config Zsh, tmux
#

apt-get update
apt-get install -y zsh curl git

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mkdir ~/.zsh

rm -rf /tmp/cloud
git clone https://github.com/gfxcc/cloud.git /tmp/cloud

copy /tmp/cloud/dot_files/* ~
# 