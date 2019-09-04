# # # # # # # # # #
# custom section  #
# # # # # # # # # #

export ZSH=/Users/gfxcc/.oh-my-zsh

alias xopen='open -a xcode'
alias mdopen='open -a MacDown'
alias ping8='ping 8.8.8.8'
alias port='sudo lsof -i -P -n | grep LISTEN'


# # # # # # # # # #
# generic section #
# # # # # # # # # #

DISABLE_AUTO_UPDATE="true"
ZSH_THEME="af-magic"

export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"

alias p3='python3.7'

# color
LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS

# network
alias p8='ping 8.8.8.8'

# git
alias gs='git status'
alias glg='git log --graph'

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
# critical import
#
source ${ZSH}/oh-my-zsh.sh
# disable autosuggestion in vscode integrated terminal
[ -z $VSCODE ] && source ${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

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
