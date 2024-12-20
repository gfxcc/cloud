# Variables
DOT_FILES_DIR=dot_files
INSTALL_CMD=

# Detect OS and set the install command
ifeq ($(shell uname), Darwin)
	INSTALL_CMD = brew install
else ifeq ($(shell uname), Linux)
	INSTALL_CMD = sudo apt-get update && sudo apt-get install -y
endif

# Targets
setup-env: install-packages copy-config

install-packages: install-basic install-zsh install-docker

install-basic:
	$(INSTALL_CMD) tmux vim

install-zsh:
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

install-docker:
	scripts/install-docker.sh	

copy-config:
	@find $(DOT_FILES_DIR) -mindepth 1 -maxdepth 1 -print -exec cp -r {} ~/ \;
