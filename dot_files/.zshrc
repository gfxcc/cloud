# # # # # # # # # #
# generic section #
# # # # # # # # # #

DISABLE_AUTO_UPDATE="true"
ZSH_THEME="af-magic"


#
# critical import
#
source ~/oh-my-zsh.sh
# disable autosuggestion in vscode integrated terminal
[ -z $VSCODE ] && source ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh


export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export LSCOLORS=exfxcxdxbxegedabagacad


alias p3='python3'

#
# network
#
alias port='sudo lsof -i -P -n | grep LISTEN'
alias p8='ping 8.8.8.8'

#
# git
#
alias gs='git status'
alias gd='git diff'
alias glg='git log --graph'


#
# docker
#
docker_build='docker build -t `basename $PWD` .'
alias docker-build=${docker_build}
alias docker-run=${docker_build}' && docker run -v $(pwd):/workdir --rm -it $(basename $PWD) bash'


#
# generic functions
#
function rgp() {
    grep -rn $1 .
}

function srgp() {
    grep --include=\*.{f,h,cpp,c,py,js,html,sh,mk} -rn $1 .
}

#
# key bind
#
bindkey "^W" forward-word
bindkey "^B" backward-word

#
# optional import
#
FILE="${HOME}/.iterm2_shell_integration.zsh" && test -f ${FILE}  && source ${FILE}
FILE="${HOME}/.zsh/local_functions.zsh" && test -f ${FILE} && source ${FILE}

# tmux
#   1. kill existed unattached session
#   2. open a new session
if [ -z $TMUX ] && [ -z $VSCODE ]; then
    unattached_sessions=$(tmux ls | grep -v attached)
    if [[ -n ${unattached_sessions} ]]; then
        for i in $(echo ${unattached_sessions} | cut -d ':' -f 1); do
            tmux kill-session -t $i
        done
    fi
    tmux -u
fi

# # # # # # # # # #
# custom section  #
# # # # # # # # # #

#
# OS specific
#

# MacOS
if [[ $(uname) = "Darwin" ]]; then
    alias xopen='open -a xcode'
fi


