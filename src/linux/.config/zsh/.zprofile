# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ssh-agent
if [ -z "$SSH_AUTH_SOCK" ]; then
  # Check for a currently running instance of the agent
  RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
  if [ "$RUNNING_AGENT" = "0" ]; then
    # Launch a new instance of the agent
    ssh-agent -s &> .ssh/ssh-agent
    # Add ssh keys
    # TODO: Enter your IdentityFile path
    # ssh-add ~/path/to/id_ed25519_****
  fi
  eval `cat .ssh/ssh-agent`
fi