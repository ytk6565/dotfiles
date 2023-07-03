# --------------------------------------------------
# ALIAS
# --------------------------------------------------

# Dock
alias rd="defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock"

# Remove macOS scalability
alias rmx="xattr -cr ."

# Check node archx
alias nodearch="node -p process.arch"

# Make containerd look like docker
alias docker="lima nerdctl"
alias docker-compose="lima nerdctl compose"

# Make corepack look like its own package manager
alias pnpm="corepack pnpm"
alias yarn="corepack yarn"
alias cleancache:corepack="rm -rf ~/.cache/node/corepack/"

# --------------------------------------------------
# COMMON
# --------------------------------------------------

source "$ZDOTDIR"/common.zshrc