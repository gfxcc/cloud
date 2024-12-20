#!/bin/sh

# Detect OS
OS=$(uname)

install_docker_mac() {
    brew install --cask docker
}

# See https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
install_docker_ubuntu() {
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}


if command -v docker &> /dev/null; then
    echo "[No-OP] Docker is already installed on Ubuntu."
    exit 0
fi

if [ "$OS" = "Darwin" ]; then
    install_docker_mac
elif [ "$OS" = "Linux" ]; then
    install_docker_ubuntu
else
    echo "Unsupported OS: $OS"
    exit 1
fi