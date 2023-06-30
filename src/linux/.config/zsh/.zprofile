# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ssh-agent
eval `ssh-agent -s` > /dev/null 2>&1
# Add ssh keys
# TODO: Enter your IdentityFile path
# eval `ssh-add ~/path/to/id_ed25519_**** > /dev/null 2>&1`