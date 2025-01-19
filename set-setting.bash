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

DIR_NAME_FROM="src"
DIR_NAME_TO="$HOME"

# --------------------------------------------------
# HOMEBREW
# --------------------------------------------------

if [[ $ARGS == **brew** ]]; then
  mv \
    "$DIR_NAME_FROM"/"$DIR_NAME_OS"/Brewfile \
    "$DIR_NAME_TO"/

  echo "brew complete."
fi

# --------------------------------------------------
# SSH
# --------------------------------------------------

if [[ $ARGS == **ssh** ]]; then
  cp \
    "$DIR_NAME_FROM"/"$DIR_NAME_OS"/.ssh/config \
    "$DIR_NAME_TO"/.ssh/

  echo "ssh complete."
fi

# --------------------------------------------------
# HAMMERSPOON
# --------------------------------------------------

if [[ $ARGS == **hammerspoon** ]]; then
  cp \
    "$DIR_NAME_FROM"/"$DIR_NAME_OS"/.hammerspoon/init.lua \
    "$DIR_NAME_TO"/.hammerspoon/

  echo "hammerspoon complete."
fi

# --------------------------------------------------
# LIMA
# --------------------------------------------------

if [[ $ARGS == **lima** ]]; then
  cp \
    "$DIR_NAME_FROM"/"$DIR_NAME_OS"/docker.yaml \
    "$DIR_NAME_TO"/

  echo "lima complete."
fi

# --------------------------------------------------
# KITTY (Deprecated)
# --------------------------------------------------

if [[ $ARGS == **kitty** ]]; then
  cp \
    "$DIR_NAME_FROM"/"$DIR_NAME_OS"/.config/kitty/kitty.conf \
    "$DIR_NAME_TO"/.config/kitty/

  echo "kitty complete."
fi

# --------------------------------------------------
# WARP
# --------------------------------------------------

if [[ $ARGS == **warp** ]]; then
  cp \
    "$DIR_NAME_FROM"/.warp/keybindings.yaml \
    "$DIR_NAME_TO"/"$DIR_NAME_OS"/.warp/

  echo "warp complete."
fi

# --------------------------------------------------
# GIT
# --------------------------------------------------

if [[ $ARGS == **git** ]]; then
  mkdir -p "$DIR_NAME_TO"/.config/git/

  rsync -a \
    "$DIR_NAME_FROM"/"$DIR_NAME_COMMON"/.config/git/ \
    "$DIR_NAME_TO"/.config/git/

  echo "git complete."
fi

# --------------------------------------------------
# ZSH
# --------------------------------------------------

if [[ $ARGS == **zsh** ]]; then
  mkdir -p "$DIR_NAME_TO"/.config/zsh/functions/
  mkdir -p "$DIR_NAME_TO"/.local/share/zsh/
  touch "$DIR_NAME_TO"/.local/share/zsh/history

  # COMMON
  rsync -a \
    "$DIR_NAME_FROM"/"$DIR_NAME_COMMON"/.config/zsh/ \
    "$DIR_NAME_TO"/.config/zsh/

  # OS
  rsync -a \
    "$DIR_NAME_FROM"/"$DIR_NAME_OS"/.config/zsh/ \
    "$DIR_NAME_TO"/.config/zsh/

  echo "zsh complete."
fi

# --------------------------------------------------

echo "OK"
exit 0