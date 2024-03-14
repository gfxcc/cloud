# af-magic.zsh-theme
# Repo: https://github.com/andyfleming/oh-my-zsh
# Direct Link: https://github.com/andyfleming/oh-my-zsh/blob/master/themes/af-magic.zsh-theme
#[[ $(jobs) != "0" ]] && bj_prompt+="[$(jobs -l | wc -l)] "

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%}✘%? %{$reset_color%})"

# Grab the current date (%D) and time (%T) wrapped in {}: {%D %T}
DALLAS_CURRENT_TIME_="%{$fg[white]%}[%{$fg[yellow]%}%*%{$fg[white]%}]%{$reset_color%}"

function preexec() {
  timer=$(date +%s)
}

function precmd() {
  if [ $timer ]; then
    local now=$(date +%s)
    local d_s=$(($now-$timer))
    local ms=$((d_ms % 1000))
    local s=$((d_s % 60))
    local m=$(((d_s / 60) % 60))
    local h=$((d_s / 3600))
    if ((h > 0)); then elapsed=${h}h${m}m
    elif ((m > 0)); then elapsed=${m}m${s}s
    elif ((s >= 10)); then elapsed=${s}.$((ms / 100))s
    elif ((s > 0)); then elapsed=${s}.$((ms / 10))s
    else elapsed=${ms}ms
    fi

    unset timer
  fi
}

# primary prompt
PROMPT='${bj_prompt}\
$DALLAS_CURRENT_TIME_%{$reset_color%} \
$FG[032]%~\
$(git_prompt_info) ${return_code}
$FG[105]%(!.#.»)%{$reset_color%} '

# The secondary prompt, printed when the shell needs more information to complete a command. E.g.
# $ echo \
# \
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'

# Display the execution time of the previous cmd on the right-hand side of the screen.
RPS1='%F{cyan}${elapsed} %{$reset_color%}'


# color vars
eval my_gray='$FG[237]'
eval my_orange='$FG[214]'


# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075]($FG[078]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$my_orange*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"
