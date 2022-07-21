# Path: ~/.oh-my-zsh/themes/lukerandall.zsh-theme
# ZSH Theme - Preview: https://cl.ly/f701d00760f8059e06dc
# Thanks to gallifrey, upon whose theme this is based

local return_code="%(?..%{$fg_bold[red]%}%? ?~F?%{$reset_color%})"

function my_git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  GIT_STATUS=$(git_prompt_status)
  [[ -n $GIT_STATUS ]] && GIT_STATUS=" $GIT_STATUS"
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$GIT_STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}


# HG INFO
local hg_info='$(my_hg_prompt_info)'
my_hg_prompt_info() {
    if [ -d '.hg' ]; then
        echo -n "${YS_VCS_PROMPT_PREFIX1}hg${YS_VCS_PROMPT_PREFIX2}"
        echo -n $(hg branch 2>/dev/null)
        if [[ "$(hg config oh-my-zsh.hide-dirty 2>/dev/null)" != "1" ]]; then
            if [ -n "$(hg status 2>/dev/null)" ]; then
                echo -n "$YS_VCS_PROMPT_DIRTY"
            else
                echo -n "$YS_VCS_PROMPT_CLEAN"
            fi
        fi
        echo -n "$YS_VCS_PROMPT_SUFFIX"
    fi
}

# PROMPT='%{$fg_bold[green]%}%n@%m%{$reset_color%} %{$fg_bold[blue]%}%2~%{$reset_color%} $(my_git_prompt_info)%{$reset_color%}%B»%b '}

# show full path, not ~:
# PROMPT='%{$fg_bold[green]%}%n@%m%{$reset_color%} %{%F{75}%}%d%{$reset_color%} $(my_git_prompt_info)%{$reset_color%}%B»%b '

# show git and hg info:
PROMPT='%{$fg_bold[green]%}%n@%m%{$reset_color%} %{$terminfo[bold]%}%{%F{75}%}%~%{$reset_color%} $(my_git_prompt_info)$(hg_prompt_info)%{$reset_color%}%B»%b '
# show hg info:
# PROMPT='%{$fg_bold[green]%}%n@%m%{$reset_color%} %{$terminfo[bold]%}%{%F{75}%}%~%{$reset_color%} $(hg_prompt_info)%{$reset_color%}%B»%b '
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=") %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%%"
ZSH_THEME_GIT_PROMPT_ADDED="+"
ZSH_THEME_GIT_PROMPT_MODIFIED="*"
ZSH_THEME_GIT_PROMPT_RENAMED="~"
ZSH_THEME_GIT_PROMPT_DELETED="!"
ZSH_THEME_GIT_PROMPT_UNMERGED="?"

# hg
ZSH_THEME_HG_PROMPT_PREFIX="%{$fg[yellow]%}hg(%{$fg[yellow]%}"
ZSH_THEME_HG_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_HG_PROMPT_DIRTY="%{$fg[yellow]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_HG_PROMPT_CLEAN="%{$fg[yellow]%}) "
