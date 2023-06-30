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
    eval `ssh-agent -s` > /dev/null 2>&1
    # Add ssh keys
    eval `ssh-add ~/.ssh/id_ed25519_github_ytk6565_signing > /dev/null 2>&1`
  fi
fi