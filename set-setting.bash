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
fi

# --------------------------------------------------
# SSH
# --------------------------------------------------

if [[ $ARGS == **ssh** ]]; then
  cp \
    "$DIR_NAME_FROM"/"$DIR_NAME_OS"/.ssh/config \
    "$DIR_NAME_TO"/.ssh/
fi

# --------------------------------------------------
# GNUPG
# --------------------------------------------------

if [[ $ARGS == **gnupg** ]]; then
  cp \
    "$DIR_NAME_FROM"/"$DIR_NAME_OS"/.gnupg/gpg-agent.conf \
    "$DIR_NAME_TO"/.gnupg/
fi

# --------------------------------------------------
# GIT
# --------------------------------------------------

if [[ $ARGS == **git** ]]; then
  mkdir -p "$DIR_NAME_TO"/.config/git/

  rsync -a \
    "$DIR_NAME_FROM"/"$DIR_NAME_COMMON"/.config/git/ \
    "$DIR_NAME_TO"/.config/git/
fi

# --------------------------------------------------
# ZSH
# --------------------------------------------------

if [[ $ARGS == **zsh** ]]; then
  mkdir -p "$DIR_NAME_TO"/.config/zsh/functions/

  # COMMON
  rsync -a \
    "$DIR_NAME_FROM"/"$DIR_NAME_COMMON"/.config/zsh/ \
    "$DIR_NAME_TO"/.config/zsh/
  cp \
    "$DIR_NAME_FROM"/"$DIR_NAME_COMMON"/.config/zsh/functions/ghq_fzf_repo.zsh \
    "$DIR_NAME_TO"/.config/zsh/functions/

  echo "$DIR_NAME_FROM"/"$DIR_NAME_OS"
  echo "$(pwd)"

  # OS
  rsync -a \
    "$DIR_NAME_FROM"/"$DIR_NAME_OS"/.config/zsh/ \
    "$DIR_NAME_TO"/.config/zsh/
fi

# --------------------------------------------------
# FISH
# --------------------------------------------------

if [[ $ARGS == **fish** ]]; then
  mkdir -p "$DIR_NAME_TO"/.config/fish/functions/

  # COMMON
  rsync -a \
    "$DIR_NAME_FROM"/"$DIR_NAME_COMMON"/.config/fish/ \
    "$DIR_NAME_TO"/.config/fish/

  # OS
  cp \
    "$DIR_NAME_FROM"/"$DIR_NAME_OS"/.config/fish/config.fish \
    "$DIR_NAME_TO"/.config/fish/
fi

# --------------------------------------------------

echo "OK"
exit 0