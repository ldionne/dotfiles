#!/usr/bin/env bash

##############################################################################
# Link each file or directory in the `symlinks` directory into `$HOME`.
##############################################################################
ln -s ${PWD}/symlinks/.bin ${HOME}/.bin
ln -s ${PWD}/symlinks/.gitconfig ${HOME}/.gitconfig
ln -s ${PWD}/symlinks/.gitignore ${HOME}/.gitignore
ln -s ${PWD}/symlinks/.iterm2.zsh ${HOME}/.iterm2.zsh
ln -s ${PWD}/symlinks/.zshrc ${HOME}/.zshrc
echo "symlinked dotfiles into ${HOME}"

##############################################################################
# Link the `sublime3/User` directory to Sublime Text's User directory.
##############################################################################
ln -s "${PWD}/sublime3/User" "${HOME}/Library/Application Support/Sublime Text 3/Packages/User"
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
echo "preferences for Sublime Text 3 set"
