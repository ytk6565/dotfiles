# --------------------------------------------------
# ALIAS
# --------------------------------------------------

# Dock
alias rd="defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock"

# Remove macOS scalability
alias rmx="xattr -cr ."

# Check node archx
alias nodearch="node -p process.arch"

# --------------------------------------------------
# COMMON
# --------------------------------------------------

source "$ZDOTDIR"/common.zshrc