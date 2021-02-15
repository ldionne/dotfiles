#!/usr/bin/env bash

set -e

DOTFILES_ROOT="${PWD}"

##############################################################################
# Link each file or directory in the `symlinks` directory into `$HOME`.
##############################################################################
echo "***********************************************"
echo "* symlinking dotfiles into ${HOME}"
echo "***********************************************"

for file in .fzf.zsh .gitconfig .gitconfig-work .gitignore .zshrc .bin .config .lldbinit; do
  dest="${HOME}/${file}"
  source="${DOTFILES_ROOT}/symlinks/${file}"
  if [[ ! -L "${dest}" ]]; then
    ln -s "${source}" "${dest}"
    echo "symlinked ${dest} to ${source}"
  fi
done
