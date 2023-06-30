#!/bin/bash

set -eu

function catch {
  echo Catch
  exit 0
}

ARGS="$*"
OS_NAME="$(uname)"
DIR_NAME_COMMON="common"
DIR_NAME_OS=""

if [[ $OS_NAME == "Linux" ]]; then
  DIR_NAME_OS="linux"
elif [[ $OS_NAME == "Darwin" ]]; then
  DIR_NAME_OS="macos"
else
  trap catch "Run on macOS or Linux"
fi

DIR_NAME_FROM="$HOME"
DIR_NAME_TO="src"

# --------------------------------------------------
# HOMEBREW
# --------------------------------------------------

if [[ $ARGS == **brew** ]]; then
  mkdir -p "$DIR_NAME_TO"/"$DIR_NAME_OS"/

  brew bundle dump

  mv \
    Brewfile \
    "$DIR_NAME_TO"/"$DIR_NAME_OS"/
    
  echo "brew complete."
fi

# --------------------------------------------------
# SSH
# --------------------------------------------------

if [[ $ARGS == **ssh** ]]; then
  mkdir -p "$DIR_NAME_TO"/"$DIR_NAME_OS"/.ssh/

  cp \
    "$DIR_NAME_FROM"/.ssh/config \
    "$DIR_NAME_TO"/"$DIR_NAME_OS"/.ssh/
    
  echo "ssh complete."
fi

# --------------------------------------------------
# HAMMERSPOON
# --------------------------------------------------

if [[ $ARGS == **hammerspoon** ]]; then
  mkdir -p "$DIR_NAME_TO"/"$DIR_NAME_OS"/.hammerspoon/

  cp \
    "$DIR_NAME_FROM"/.hammerspoon/init.lua \
    "$DIR_NAME_TO"/"$DIR_NAME_OS"/.hammerspoon/
    
  echo "hammerspoon complete."
fi

# --------------------------------------------------
# LIMA
# --------------------------------------------------

if [[ $ARGS == **lima** ]]; then
  cp \
    "$DIR_NAME_FROM"/docker.yaml \
    "$DIR_NAME_TO"/"$DIR_NAME_OS"/
    
  echo "lima complete."
fi

# --------------------------------------------------
# KITTY
# --------------------------------------------------

if [[ $ARGS == **kitty** ]]; then
  cp \
    "$DIR_NAME_FROM"/.config/kitty/kitty.conf \
    "$DIR_NAME_TO"/"$DIR_NAME_OS"/.config/kitty/
    
  echo "kitty complete."
fi

# --------------------------------------------------
# GIT
# --------------------------------------------------

if [[ $ARGS == **git** ]]; then
  mkdir -p "$DIR_NAME_TO"/"$DIR_NAME_COMMON"/.config/git/

  cp \
    "$DIR_NAME_FROM"/.config/git/_base.config \
    "$DIR_NAME_FROM"/.config/git/_github.config \
    "$DIR_NAME_FROM"/.config/git/_signing_ssh.config \
    "$DIR_NAME_FROM"/.config/git/config \
    "$DIR_NAME_FROM"/.config/git/ignore \
    "$DIR_NAME_TO"/"$DIR_NAME_COMMON"/.config/git/
    
  echo "git complete."
fi

# --------------------------------------------------
# ZSH
# --------------------------------------------------

if [[ $ARGS == **zsh** ]]; then
  # COMMON
  mkdir -p "$DIR_NAME_TO"/"$DIR_NAME_COMMON"/.config/zsh/functions/

  cp \
    "$DIR_NAME_FROM"/.config/zsh/.zimrc \
    "$DIR_NAME_FROM"/.config/zsh/.zshrc \
    "$DIR_NAME_FROM"/.config/zsh/abbreviations \
    "$DIR_NAME_FROM"/.config/zsh/common.zshrc \
    "$DIR_NAME_TO"/"$DIR_NAME_COMMON"/.config/zsh/
  cp \
    "$DIR_NAME_FROM"/.config/zsh/functions/ghq_fzf_repo.zsh \
    "$DIR_NAME_TO"/"$DIR_NAME_COMMON"/.config/zsh/functions/

  # OS
  mkdir -p "$DIR_NAME_TO"/"$DIR_NAME_OS"/.config/zsh/functions/

  cp \
    "$DIR_NAME_FROM"/.config/zsh/.zprofile \
    "$DIR_NAME_FROM"/.config/zsh/.zshenv \
    "$DIR_NAME_FROM"/.config/zsh/config.zshrc \
    "$DIR_NAME_TO"/"$DIR_NAME_OS"/.config/zsh/
    
  echo "zsh complete."
fi

# --------------------------------------------------

echo "OK"
exit 0