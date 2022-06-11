# --------------------------------------------------
# ENV
# --------------------------------------------------

export HISTFILE="$XDG_DATA_HOME"/zsh/history

# --------------------------------------------------
# COMMANDS
# --------------------------------------------------

# nodenv
eval "$(nodenv init -)"

# Overwrite eriner theme prompt new line
_prompt_eriner_end() {
  print -n "%k%F{${BG_COLOR}}%f
$ "
}

# --------------------------------------------------
# ALIAS
# --------------------------------------------------

alias r='source ~/.config/zsh/.zshrc'
alias q='exit'
alias ls='exa --classify --icons -h'
alias la='ls -la'

# interactive
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Git
alias gt="git log --graph --pretty=format:'%x09%C(auto) %h %Cgreen %ar %Creset%x09by\"%C(cyan ul)%an%Creset\" %x09%C(auto)%s %d'"
alias gsut='git branch --set-upstream-to=origin/$(git branch --show-current) $(git branch --show-current)'

# --------------------------------------------------
# FUNCTIONS
# --------------------------------------------------

source "$HOME"/.config/zsh/functions/ghq_fzf_repo.zsh
