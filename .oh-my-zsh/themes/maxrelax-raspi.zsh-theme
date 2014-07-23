# Maxrelax-RasPi Theme
# ------------------------------------------------
# Clean, simple, compatible and meaningful.
#
# https://github.com/maxrelax/raspi-dotfiles
# MIT License
# July 2014
# Inspired by flazz.zsh-theme

if [ "$(whoami)" = "root" ]
then CARETCOLOR="red"
else CARETCOLOR="blue"
fi

# color vars
eval my_gray='$FG[237]'
eval my_orange='$FG[214]'

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"


PROMPT='$my_gray%m%{${reset_color}%}%{${fg_bold[magenta]}%} :: %{$reset_color%}%{${fg[green]}%}%3~ $(git_prompt_info)%{${fg_bold[$CARETCOLOR]}%}%#%{${reset_color}%} '

RPS1='$(vi_mode_prompt_info) ${return_code}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

MODE_INDICATOR="%{$fg_bold[magenta]%}<%{$reset_color%}%{$fg[magenta]%}<<%{$reset_color%}"

# TODO use 265 colors
#MODE_INDICATOR="$FX[bold]$FG[020]<$FX[no_bold]%{$fg[blue]%}<<%{$reset_color%}"
# TODO use two lines if git
