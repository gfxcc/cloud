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

install-packages: install-basic install-zsh install-neovim install-docker

install-basic:
	$(INSTALL_CMD) tmux git curl

install-zsh:
	sudo apt-get install -y zsh
	curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh
	@if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then \
		echo "Cloning zsh-autosuggestions..."; \
		git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions; \
	else \
		echo "zsh-autosuggestions is already installed."; \
	fi

install-neovim:
	$(INSTALL_CMD) neovim
	# Install https://github.com/junegunn/vim-plug?tab=readme-ov-file#installation
	sh -c 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	nvim --headless +PlugInstall +qa

install-docker:
	scripts/install-docker.sh	

copy-config:
	@find $(DOT_FILES_DIR) -mindepth 1 -maxdepth 1 -print -exec cp -r {} ~/ \;

test-ub:
	@docker run -it --rm \
		-v `pwd`:/app \
		-w /app \
		--env HOME=/home/nonrootuser \
		ubuntu:22.04 /bin/bash -c "\
			apt-get update && apt-get install -y sudo make && \
			useradd -m -s /bin/bash -G sudo nonrootuser && \
			echo 'nonrootuser ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
			echo -e '\n\n\nEnv is ready. Start test in 5 seconds...\n\n\n'; sleep 5 && \
			su - nonrootuser -c 'cd /app && make setup-env && zsh'"

test-mac:
	echo "Not implemented yet"
