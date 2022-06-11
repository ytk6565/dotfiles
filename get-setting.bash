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
fi

# --------------------------------------------------
# SSH
# --------------------------------------------------

if [[ $ARGS == **ssh** ]]; then
  mkdir -p "$DIR_NAME_TO"/"$DIR_NAME_OS"/.ssh/

  cp \
    "$DIR_NAME_FROM"/.ssh/config \
    "$DIR_NAME_TO"/"$DIR_NAME_OS"/.ssh/
fi

# --------------------------------------------------
# LIMA
# --------------------------------------------------

if [[ $ARGS == **lima** ]]; then
  cp \
    "$DIR_NAME_FROM"/docker.yaml \
    "$DIR_NAME_TO"/"$DIR_NAME_OS"/
fi

# --------------------------------------------------
# HAMMERSPOON
# --------------------------------------------------

if [[ $ARGS == **hammerspoon** ]]; then
  mkdir -p "$DIR_NAME_TO"/"$DIR_NAME_OS"/.hammerspoon/

  cp \
    "$DIR_NAME_FROM"/.hammerspoon/init.lua \
    "$DIR_NAME_TO"/"$DIR_NAME_OS"/.hammerspoon/
fi

# --------------------------------------------------
# GNUPG
# --------------------------------------------------

if [[ $ARGS == **gnupg** ]]; then
  mkdir -p "$DIR_NAME_TO"/"$DIR_NAME_OS"/.gnupg/

  cp \
    "$DIR_NAME_FROM"/.gnupg/gpg-agent.conf \
    "$DIR_NAME_TO"/"$DIR_NAME_OS"/.gnupg/
fi

# --------------------------------------------------
# GIT
# --------------------------------------------------

if [[ $ARGS == **git** ]]; then
  mkdir -p "$DIR_NAME_TO"/"$DIR_NAME_COMMON"/.config/git/

  cp \
    "$DIR_NAME_FROM"/.config/git/_base.config \
    "$DIR_NAME_FROM"/.config/git/config \
    "$DIR_NAME_FROM"/.config/git/ignore \
    "$DIR_NAME_TO"/"$DIR_NAME_COMMON"/.config/git/
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
fi

# --------------------------------------------------
# FISH
# --------------------------------------------------

if [[ $ARGS == **fish** ]]; then
  # COMMON
  mkdir -p "$DIR_NAME_TO"/"$DIR_NAME_COMMON"/.config/fish/functions/

  cp \
    "$DIR_NAME_FROM"/.config/fish/common.fish \
    "$DIR_NAME_FROM"/.config/fish/fish_plugins \
    "$DIR_NAME_TO"/"$DIR_NAME_COMMON"/.config/fish/
  cp \
    "$DIR_NAME_FROM"/.config/fish/functions/ghq_fzf_repo.fish \
    "$DIR_NAME_TO"/"$DIR_NAME_COMMON"/.config/fish/functions/

  # OS
  mkdir -p "$DIR_NAME_TO"/"$DIR_NAME_OS"/.config/fish/functions/

  cp \
    "$DIR_NAME_FROM"/.config/fish/config.fish \
    "$DIR_NAME_TO"/"$DIR_NAME_OS"/.config/fish/

  if [[ $OS_NAME == "Darwin" ]]; then
    cp \
      "$DIR_NAME_FROM"/.config/fish/functions/switch_arch.fish \
      "$DIR_NAME_TO"/"$DIR_NAME_COMMON"/.config/fish/functions/
  fi
fi

# --------------------------------------------------

echo "OK"
exit 0