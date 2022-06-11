# --------------------------------------------------
# PATH
# --------------------------------------------------

# Homebrew
eval ($HOME/.linuxbrew/bin/brew shellenv)

# nodenv
eval (nodenv init - | source)

# GPG
export GPG_TTY=(tty)

# --------------------------------------------------
# Alias
# --------------------------------------------------

alias r='source ~/.config/fish/config.fish'
alias q='exit'

# interactive
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Git
alias grsh="git reset --soft HEAD\^"
alias gt="git log --graph --pretty=format:'%x09%C(auto) %h %Cgreen %ar %Creset%x09by\"%C(cyan ul)%an%Creset\" %x09%C(auto)%s %d'"
alias gsut="git branch --set-upstream-to=origin/(git branch --show-current) (git branch --show-current)"

# --------------------------------------------------
# FUNCTIONS
# --------------------------------------------------

source "$HOME/.config/fish/functions/ghq_fzf_repo.fish"

# --------------------------------------------------
# THEME
# --------------------------------------------------

set -g theme_display_git_default_branch yes
set -g theme_git_default_branches master main
set -g theme_date_format "+%a %H:%M"
set -g theme_date_format "+[%T]"
set -g theme_date_timezone Asia/Tokyo
set -g theme_color_scheme dracula
set -g theme_newline_cursor yes
set -g theme_newline_prompt '$ '

