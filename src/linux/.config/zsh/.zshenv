# XDG
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state

# History
export HISTFILE="$XDG_DATA_HOME"/zsh/history

# Homebrew
export PATH="$HOME/.linuxbrew/bin:$PATH"

# GOPATH
export PATH="$HOME/go/bin:$PATH"

# FZF
export FZF_DEFAULT_OPTS='--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*" --exit-0'

# GPG
export GPG_TTY="$(tty)"

# LANG
export LANG="ja_JP.UTF-8"