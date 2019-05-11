
# # # # # # # # # #
# generic section #
# # # # # # # # # #

DISABLE_AUTO_UPDATE="true"
ZSH_THEME="af-magic"

export ZSH=/Users/ycao155/.oh-my-zsh
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"

alias gs='git status'
alias p3='python3.7'

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
# Disable autosuggestion in vscode integrated terminal.
#   Config terminal.integrated.env.osx in vscode to set VSCODE
[ -z $VSCODE ] && source ${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

#
# optional import
#
FILE="${HOME}/.iterm2_shell_integration.zsh" && test -f ${FILE}  && source ${FILE}
FILE="${HOME}/.zsh/local_functions.zsh" && test -f ${FILE} && source ${FILE}

# tmux
if [ -z $TMUX ] && [ -z $VSCODE ]; then
    tmux -u
fi

# # # # # # # # # #
# custom section  #
# # # # # # # # # #


