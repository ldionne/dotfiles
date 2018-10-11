#!/usr/bin/env bash

set -e

DOTFILES_ROOT="${PWD}"

##############################################################################
# Link each file or directory in the `symlinks` directory into `$HOME`.
##############################################################################
echo "***********************************************"
echo "* symlinking dotfiles into ${HOME}"
echo "***********************************************"

for file in .fzf.zsh .gitconfig .gitconfig-work .gitignore .zshrc .bin .config; do
  dest="${HOME}/${file}"
  source="${DOTFILES_ROOT}/symlinks/${file}"
  if [[ ! -L "${dest}" ]]; then
    ln -s "${source}" "${dest}"
    echo "symlinked ${dest} to ${source}"
  fi
done

##############################################################################
# Link the Sublime package preferences in the sublime3 directory to the
# Sublime Text directory that contains those settings.
##############################################################################
echo "***********************************************"
echo "* symlinking Sublime Text 3 preferences"
echo "***********************************************"

SUBLIME_DATA_DIR="${HOME}/Library/Application Support/Sublime Text 3"
for file in "${DOTFILES_ROOT}/sublime3"/*; do
  dest="${SUBLIME_DATA_DIR}/Packages/User/$(basename "${file}")"
  if [[ ! -L "${dest}" ]]; then
    ln -s "${file}" "${dest}"
    echo "symlinked Sublime Text preferences ${dest} to ${file}"
  fi
done
