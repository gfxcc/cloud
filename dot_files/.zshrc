export ZSH=~/.oh-my-zsh

# # # # # # # # # #
# Function section#
# # # # # # # # # #

# Attachs to a tmux session or creates a new one if it doesn't exist
tmux_create_or_attach() {
  # Name of the tmux session to create or attach to
  local session_name="${1:-default}"

  # Check if the session already exists
  if tmux has-session -t "$session_name" 2>/dev/null; then
    echo "Attaching to existing tmux session: $session_name"
    tmux attach-session -t "$session_name"
  else
    echo "Creating new tmux session: $session_name"
    tmux new-session -s "$session_name"
  fi
}

#   1. kill existed unattached session
#   2. open a new session
#
# This is helpful to avoid creating lots of unused session on local dev machine
# when you do not want to share a same session across iterm tabs.
# Not suitable for a long running server
tmux_clean_and_create() {
    if [ -z $TMUX ] ; then
        unattached_sessions=$(tmux ls | grep -v attached)
        if [[ -n ${unattached_sessions} ]]; then
            for i in $(echo ${unattached_sessions} | cut -d ':' -f 1); do
                tmux kill-session -t $i
            done
        fi
        tmux -u
    fi
}

# Entrance of tmux
tmux_entrance() {
    # Do not use tmux in vscode or a tmux env
    if [[ -n $VSCODE || -n $TMUX ]]; then
        return
    fi

    if [[ $(uname) = "Darwin" ]]; then
        # For MacOS
        tmux_clean_and_create
    else
        tmux_create_or_attach
    fi
}

# # # # # # # # # #
# generic section #
# # # # # # # # # #

DISABLE_AUTO_UPDATE="true"
ZSH_THEME="af-magic"

plugins=( 
    # other plugins...
    zsh-autosuggestions
)


#
# critical import
#
source ${ZSH}/oh-my-zsh.sh
# disable autosuggestion in vscode integrated terminal
[ -z $VSCODE ] && source ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh


export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export LSCOLORS=exfxcxdxbxegedabagacad


alias p3='python3'
alias vim='nvim'

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
FILE="${HOME}/.zsh/local_alias.zsh" && test -f ${FILE} && source ${FILE}

tmux_entrance

# # # # # # # # # #
# custom section  #
# # # # # # # # # #

#
# OS specific
#

# MacOS
if [[ $(uname) = "Darwin" ]]; then
    alias xopen='open -a xcode'
    alias check-temp='sudo powermetrics -i 1000 --samplers smc | grep -E "(Fan|temp)"'
fi
