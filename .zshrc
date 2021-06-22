# --------------------------------------------------
# PATH
# --------------------------------------------------

PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
export PATH

# M1 Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
# export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# --------------------------------------------------
# VARIABLES
# --------------------------------------------------

# Environment
export LANG="ja_JP.UTF-8"
export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

# GPG
export GPG_TTY=$(tty)

# Shared
export SHARED="/Users/Shared"

# --------------------------------------------------
# General
# --------------------------------------------------

bindkey -e

#bindkey -v
setopt auto_cd
setopt auto_list
setopt auto_menu
setopt auto_pushd
setopt complete_in_word
setopt extended_glob
setopt list_packed
setopt list_types
setopt mark_dirs
setopt no_beep
setopt no_flow_control
setopt pushd_ignore_dups

# Complement
autoload -Uz compinit ; compinit

# Color
autoload -U colors
colors
zstyle ':completion:*' list-colors "${LS_COLORS}"

# zstyle
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_no_store
setopt hist_expand
setopt inc_append_history
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

# --------------------------------------------------
# Alias
# --------------------------------------------------

alias ls='ls --color=auto'
alias ls='ls -G'
alias ll='ls -alF'
alias ll='ls -lh'
alias ll='ls -l'
alias la='ls -A'
alias la='ls -a'
alias l='ls -CF'
alias ed='code .'
alias r='source ~/.zshrc'
alias q='exit'

# interactive
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Git
alias grsh='git reset --soft HEAD\^'
alias gss='(){git stash save "$1"}'
alias gsa='(){git stash apply stash@{"$1"}}'
alias gsp='(){git stash pop stash@{"$1"}}'
alias gt="git log --graph --pretty=format:'%x09%C(auto) %h %Cgreen %ar %Creset%x09by\"%C(cyan ul)%an%Creset\" %x09%C(auto)%s %d'"

# Python Web Server
alias pyserver="python -m SimpleHTTPServer "

# Dock
alias rd="defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock"

# Remove macOS scalability
alias rmx="xattr -cr ."

# Check node archx
alias nodearch="node -p process.arch"

# --------------------------------------------------
# arch
# --------------------------------------------------

# switch-arch
typeset -U path PATH
path=(
    /opt/homebrew/bin(N-/)
    /usr/local/bin(N-/)
    $path
)

if (( $+commands[sw_vers] )) && (( $+commands[arch] )); then
    [[ -x /usr/local/bin/brew ]] && alias brew="arch -arch x86_64 /usr/local/bin/brew"
    alias x64='exec arch -x86_64 /bin/zsh'
    alias a64='exec arch -arm64e /bin/zsh'
    switch-arch() {
        if  [[ "$(uname -m)" == arm64 ]]; then
            arch=x86_64
        elif [[ "$(uname -m)" == x86_64 ]]; then
            arch=arm64e
        fi
        exec arch -arch $arch /bin/zsh
    }
fi

setopt magic_equal_subst

# --------------------------------------------------
# zplug
# --------------------------------------------------

# zplug
# git clone https://github.com/zplug/zplug $ZPLUG_HOME
export ZPLUG_HOME=~/.zplug

source $ZPLUG_HOME/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "mrowa44/emojify", as:command
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi
zplug load
