# --------------------------------------------------
# PATH
# --------------------------------------------------

# M1 Homebrew
eval (/opt/homebrew/bin/brew shellenv)
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
# export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# nodenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval (nodenv init - | source)

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
alias grsh='git reset --soft HEAD\^'
alias gt="git log --graph --pretty=format:'%x09%C(auto) %h %Cgreen %ar %Creset%x09by\"%C(cyan ul)%an%Creset\" %x09%C(auto)%s %d'"

# Python Web Server
alias pyserver="python -m SimpleHTTPServer "

# Dock
alias rd="defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock"

# Remove macOS scalability
alias rmx="xattr -cr ."

# Check node arch
alias nodearch="node -p process.arch"

# --------------------------------------------------
# FUNCTIONS
# --------------------------------------------------

source /Users/Shared/.config/fish/functions/ghq_fzf_repo.fish
source /Users/Shared/.config/fish/functions/switch_arch.fish

# --------------------------------------------------
# THEME
# --------------------------------------------------

set -g theme_display_git_default_branch yes
set -g theme_git_default_branches master main
# set -g theme_date_format "+%a %H:%M"
set -g theme_date_format "+[%T]"
set -g theme_date_timezone Asia/Tokyo
set -g theme_color_scheme dracula
set -g theme_newline_cursor yes
set -g theme_newline_prompt '$ '
