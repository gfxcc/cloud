# Path to your oh-my-zsh installation.
export ZSH=/Users/gfxcc/.oh-my-zsh

# abbreviation for command
alias py='python'

#alias rm='rm -i'

alias gh='cd ~/Dropbox/Program/'
alias xopen='open -a xcode'
alias mdopen='open -a MacDown'
alias ping8='ping 8.8.8.8'
alias port='sudo lsof -i -P -n | grep LISTEN'

# location alias
alias lp='~/Program'
alias dp='~/Dropbox/Program'

# git alias
alias gs='git status'

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="af-magic"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -s $(brew --prefix)/etc/profile.d/autojump.sh  ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh


#
# customized functions
#

# recursively search KEYWORD under current path
rgp() {
    if [[ "$#" != 0  ]] && [[ "$#" == 1  ]]; then
        grep -Rn "$1" ./*
    else
        echo "usage: rgp \"keywork\""
    fi

}

init_cmake() {
    wget "https://raw.githubusercontent.com/gfxcc/cloud/master/init/cmake/CMakeLists.txt"
    mkdir build
}

init_gtest() {
    wget "https://raw.githubusercontent.com/gfxcc/cloud/master/init/gtest/CMakeLists.txt"
    wget "https://raw.githubusercontent.com/gfxcc/cloud/master/init/gtest/unittest.cc"
    mkdir build
}

init_make() {
    wget "https://raw.githubusercontent.com/gfxcc/cloud/master/init/make/Makefile"
}


clean_vim() {
    setopt rm_star_silent
    rm -rf ~/.vimswap/*
    rm -rf ~/.vimviews/*
    setopt no_rm_star_silent
}

clean_cmake() {
    rm -rf CMakeFiles
    rm CMakeCache.txt
}

startvimprofile() {
    vim --cmd 'profile start vim.profile' \
        --cmd 'profile func *'                 \
        --cmd 'profile file *' $1
}


sync_conf() {
    if [[ "$#" -ge 1  ]]; then
        if [[ "$1" == "pull" ]]; then
            echo "start pull mode"
            # clone config repo
            git clone https://github.com/gfxcc/cloud sync_conf_tmp
            cp sync_conf_tmp/conf/.vimrc ~/.vimrc
            cp sync_conf_tmp/conf/.zhsrc ~/.zshrc
            setopt rm_star_silent
            rm -rf sync_conf_tmp
            setopt no_rm_star_silent
            echo "sync_conf pull SUCCESSE"
        elif [[ "$1" == "push" ]]; then
            echo "start push mode"
            # clone config repo
            git clone https://github.com/gfxcc/cloud sync_conf_tmp
            cp ~/.vimrc sync_conf_tmp/conf/.vimrc
            cp ~/.zshrc sync_conf_tmp/conf/.zshrc

            cd sync_conf_tmp
            git add conf/.vimrc
            git add conf/.zshrc

            # check if commit message is given
            if [[ "$#" == 2 ]]; then
                COMMIT_MSG=$2
            else
                COMMIT_MSG="sync_conf push on $(hostname)"
            fi
            git commit -m "${COMMIT_MSG}"
            git push
            cd ..
            setopt rm_star_silent
            rm -rf sync_conf_tmp
            setopt no_rm_star_silent
            echo "sync_conf push SUCCESSE"
        fi
    else
        echo "Usage: sync_conf (pull|push)"
    fi
}
