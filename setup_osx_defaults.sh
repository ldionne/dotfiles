#!/usr/bin/env bash

##
## This script sets a few OS X preferences to improve productivity.
##

##############################################################################
# Finder
##############################################################################

# Menu bar: disable transparency
defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Show the ~/Library folder
chflags nohidden ~/Library

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `Nlsv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Set the Finder prefs for showing a few different volumes on the Desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Show hidden files by default.
defaults write com.apple.finder AppleShowAllFiles -bool true

# Make dialog boxes appear faster. For example, the `Save As' box emerges
# from the window's title bar. Default is .2 seconds.
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Disable window animations like starting small and zooming in to
# the correct size.
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0


##############################################################################
# Dock
##############################################################################

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Enable spring-loading when hovering dock items.
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Disable automatic quit of applications.
defaults write -g NSDisableAutomaticTermination -bool true

# Set the size of the dock
defaults write com.apple.dock largesize -float 94

# Disable dock magnification
defaults write com.apple.dock magnification -bool false


##############################################################################
# Keyboard
##############################################################################

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Enable full keyboard access for all controls
# Essentially allows tabbing in modal dialogs
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Reduce the delay before keys are repeated when holding down a key
defaults write -globalDomain InitialKeyRepeat -int 15

##############################################################################
# Mail
##############################################################################

# Copy email addresses as `foo@example.com` instead of
# `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false


##############################################################################
# Trackpad
##############################################################################

# Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Enable drag with double click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool true

# global trackpad tracking speed (1...5)
defaults write com.apple.trackpad.scaling -float 1.5


##############################################################################
# System/misc
##############################################################################

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0


##############################################################################
echo "OS X preferences set; some settings may need a restart to take effect"
