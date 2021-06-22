# Install fish
if hash fish > /dev/null; then
  echo "fish is already installed."
else
  echo "Install fish"
  brew update
  brew install fish
fi

# Normalize the fish path (Avoid duplicate slashes)
FISH_PATH_RAW=$(which fish)
FISH_PATH=${FISH_PATH_RAW//\/\//\/}

# Add fish to /etc/shells
if grep $FISH_PATH /etc/shells > /dev/null; then
  echo "fish already exists in /etc/shells"
else
  echo "Add fish to /etc/shells"
  sudo sh -c "sudo echo $FISH_PATH >> /etc/shells"
fi

# Configure config.fish
if [ -f ~/.config/fish/config.fish ]; then # Verify the existence of the file
  echo "config.fish already exists"
else
  echo "Configure config.fish"
  mkdir -p ~/.config/fish/
  touch ~/.config/fish/config.fish
  echo "source /Users/Shared/.config/fish/config.fish" > ~/.config/fish/config.fish
fi

# Change login shell
if [[ $SHELL == $FISH_PATH ]]; then # string comparison [[]]
  echo "fish is already set as the login shell"
else
  echo "Change login shell"
  chsh -s $FISH_PATH
fi

# Change use shell
fish
