# af-magic.zsh-theme
# Repo: https://github.com/andyfleming/oh-my-zsh
# Direct Link: https://github.com/andyfleming/oh-my-zsh/blob/master/themes/af-magic.zsh-theme
#[[ $(jobs) != "0" ]] && bj_prompt+="[$(jobs -l | wc -l)] "

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%}✘%? %{$reset_color%})"

# Grab the current date (%D) and time (%T) wrapped in {}: {%D %T}
DALLAS_CURRENT_TIME_="%{$fg[white]%}[%{$fg[yellow]%}%*%{$fg[white]%}]%{$reset_color%}"



# primary prompt
PROMPT='${bj_prompt}\
$DALLAS_CURRENT_TIME_%{$reset_color%} \
$FG[032]%~\
$(git_prompt_info) ${return_code}
$FG[105]%(!.#.»)%{$reset_color%} '
RPROMPT='%M'

PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
#RPS1='${return_code}'


# color vars
eval my_gray='$FG[237]'
eval my_orange='$FG[214]'


# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075]($FG[078]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$my_orange*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"