#!/bin/bash

# Navigate to dotfiles directory
cd "$(dirname "$0")"

# Create necessary directories if they don't exist
mkdir -p ~/.config

# Use stow to create symlinks
echo "Creating symlinks with stow..."
stow --verbose=2 zsh
stow --verbose=2 nvim
stow --verbose=2 tmux
stow --verbose=2 git
# Add any other dotfile directories you create

# Special case for iTerm2 preferences
if [ -f "./iterm2/com.googlecode.iterm2.plist" ]; then
  echo "Setting up iTerm2 preferences..."
  cp ./iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/
fi

echo "Symlinks created successfully!"
