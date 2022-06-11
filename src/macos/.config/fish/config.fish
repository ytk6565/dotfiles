# --------------------------------------------------
# PATH
# --------------------------------------------------

# Homebrew
eval (/opt/homebrew/bin/brew shellenv)

# --------------------------------------------------
# Alias
# --------------------------------------------------

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

source "$HOME"/.config/fish/functions/ghq_fzf_repo.fish
source "$HOME"/.config/fish/functions/switch_arch.fish

# --------------------------------------------------
# COMMON
# --------------------------------------------------

source "$HOME/.config/fish/common.fish"