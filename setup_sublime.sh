#!/usr/bin/env bash

set -e

DOTFILES_ROOT="${PWD}"

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
