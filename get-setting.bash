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

# --------------------------------------------------
# HOMEBREW
# --------------------------------------------------

if [[ $ARGS == **brew** ]]; then
  mkdir -p src/"$DIR_NAME_OS"/

  brew bundle dump

  mv Brewfile src/"$DIR_NAME_OS"/
fi

# --------------------------------------------------
# SSH
# --------------------------------------------------

if [[ $ARGS == **ssh** ]]; then
  mkdir -p src/"$DIR_NAME_OS"/.ssh/

  cp \
    "$HOME"/.ssh/config \
    src/"$DIR_NAME_OS"/.ssh/
fi

# --------------------------------------------------
# GNUPG
# --------------------------------------------------

if [[ $ARGS == **gnupg** ]]; then
  mkdir -p src/"$DIR_NAME_OS"/.gnupg/

  cp \
    "$HOME"/.gnupg/gpg-agent.conf \
    src/"$DIR_NAME_OS"/.gnupg/
fi

# --------------------------------------------------
# GIT
# --------------------------------------------------

if [[ $ARGS == **git** ]]; then
  mkdir -p src/"$DIR_NAME_COMMON"/.config/git/

  cp \
    "$HOME"/.config/git/_base.config \
    "$HOME"/.config/git/config \
    "$HOME"/.config/git/ignore \
    src/"$DIR_NAME_COMMON"/.config/git/
fi

# --------------------------------------------------
# ZSH
# --------------------------------------------------

if [[ $ARGS == **zsh** ]]; then
  # COMMON
  mkdir -p src/"$DIR_NAME_COMMON"/.config/zsh/functions/

  cp \
    "$HOME"/.config/zsh/.zimrc \
    "$HOME"/.config/zsh/.zshrc \
    "$HOME"/.config/zsh/abbreviations \
    "$HOME"/.config/zsh/common.zshrc \
    src/"$DIR_NAME_COMMON"/.config/zsh/
  cp \
    "$HOME"/.config/zsh/functions/ghq_fzf_repo.zsh \
    src/"$DIR_NAME_COMMON"/.config/zsh/functions/

  # OS
  mkdir -p src/"$DIR_NAME_OS"/.config/zsh/functions/

  cp \
    "$HOME"/.config/zsh/.zprofile \
    "$HOME"/.config/zsh/.zshenv \
    "$HOME"/.config/zsh/config.zshrc \
    src/"$DIR_NAME_OS"/.config/zsh/
fi

# --------------------------------------------------
# FISH
# --------------------------------------------------

if [[ $ARGS == **fish** ]]; then
  # COMMON
  mkdir -p src/"$DIR_NAME_COMMON"/.config/fish/functions/

  cp \
    "$HOME"/.config/fish/common.fish \
    "$HOME"/.config/fish/fish_plugins \
    src/"$DIR_NAME_COMMON"/.config/fish/
  cp \
    "$HOME"/.config/fish/functions/ghq_fzf_repo.fish \
    src/"$DIR_NAME_COMMON"/.config/fish/functions/

  # OS
  mkdir -p src/"$DIR_NAME_OS"/.config/fish/functions/

  cp \
    "$HOME"/.config/fish/config.fish \
    src/"$DIR_NAME_OS"/.config/fish/
fi

# --------------------------------------------------

echo "OK"
exit 0