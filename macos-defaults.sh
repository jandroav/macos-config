#!/usr/bin/env bash
# macOS system preferences
# Run: bash macos-defaults.sh && killall Dock

# Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 46
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock wvous-br-corner -int 14  # bottom-right: Quick Note

# Global
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 3
defaults write NSGlobalDomain com.apple.mouse.scaling -float 3
defaults write NSGlobalDomain com.apple.sound.uiaudio.enabled -int 0

# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

# Restart affected apps
killall Dock
killall Finder
