#! /bin/env bash

#
# dotfiles managements system installation script
#

REPO=$(realpath $(dirname $0))
BINARY=$REPO/bin/dotfiles
BINARY_INSTALL_DIR_PATH=$HOME/.local/bin
BINARY_LINK_PATH=$BINARY_INSTALL_DIR_PATH/dotfiles
DATA_INSTALL_DIR_PATH=$HOME/.local/share/dotfiles
REPO_LINK_PATH=$DATA_INSTALL_DIR_PATH/repo

check_binary_link() {
  if [[ -e $BINARY_LINK_PATH || -h $BINARY_LINK_PATH ]]; then
    if [[ -h $BINARY_LINK_PATH && $(readlink -f $BINARY_LINK_PATH) == "$BINARY" ]]; then
      return 0
    fi
    echo "File $BINARY_LINK_PATH already exists." >&2
    return 1
  fi
}

install_binary_link() {
  mkdir -p $BINARY_INSTALL_DIR_PATH && ln -fs $BINARY $BINARY_LINK_PATH && echo "Created symlink $BINARY_LINK_PATH -> $BINARY"
}

check_repo_link() {
  if [[ -e $REPO_LINK_PATH || -h $REPO_LINK_PATH ]]; then
    if [[ -h $REPO_LINK_PATH && $(readlink -f $REPO_LINK_PATH) == "$REPO" ]]; then
      return 0
    fi
    echo "File $REPO_LINK_PATH already exists." >&2
    return 1
  fi
}

install_repo_link() {
  mkdir -p $DATA_INSTALL_DIR_PATH && ln -fsn $REPO $REPO_LINK_PATH && echo "Created symlink $REPO_LINK_PATH -> $REPO"
}

install() {
  (check_binary_link && check_repo_link && install_binary_link && install_repo_link && echo OK) || return 1
}

install
