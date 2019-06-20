
# # # # # # # # # #
# generic section #
# # # # # # # # # #

DISABLE_AUTO_UPDATE="true"
ZSH_THEME="af-magic"

export ZSH=/Users/gfxcc/.oh-my-zsh
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"

alias p3='python3.7'

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
bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word

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
if [ -z $TMUX ] && [ -z $VSCODE ]; then
    unattached_session=$(tmux ls | grep -v attached | head -1)
    if [[ -z ${unattached_session} ]]; then
        tmux -u
    else
        tmux a
    fi
fi

# # # # # # # # # #
# custom section  #
# # # # # # # # # #

