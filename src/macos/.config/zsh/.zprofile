# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# kitty
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="kitty +kitten ssh"