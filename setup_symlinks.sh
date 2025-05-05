#!/bin/bash
# setup_symlinks.sh - Create symlinks using stow

# Navigate to dotfiles directory
cd "$(dirname "$0")"

# Create necessary directories if they don't exist
mkdir -p ~/.config ~/.config/yabai ~/.config/skhd

# Use stow to create symlinks
echo "Creating symlinks with stow..."
stow --verbose=2 zsh
stow --verbose=2 nvim
stow --verbose=2 tmux
stow --verbose=2 git
# Remove hammerspoon since it's not working
# stow --verbose=2 hammerspoon 

# Add the new window management tools
stow --verbose=2 yabai
stow --verbose=2 skhd

# Special case for iTerm2 preferences
if [ -f "./iterm2/com.googlecode.iterm2.plist" ]; then
  echo "Setting up iTerm2 preferences..."
  cp ./iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/
fi

# Set execute permissions for window manager scripts
if [ -f "$HOME/.config/yabai/yabairc" ]; then
  echo "Setting executable permissions for yabairc..."
  chmod +x "$HOME/.config/yabai/yabairc"
fi

# Start services using the direct commands instead of brew services
echo "Starting window management services..."
if command -v yabai &> /dev/null; then
  # Stop service if already running
  yabai --stop-service 2>/dev/null || true
  echo "Starting yabai service..."
  yabai --start-service
else
  echo "⚠️ yabai not found. Make sure it's installed."
fi

if command -v skhd &> /dev/null; then
  # Stop service if already running
  skhd --stop-service 2>/dev/null || true
  echo "Starting skhd service..."
  skhd --start-service
else
  echo "⚠️ skhd not found. Make sure it's installed."
fi

# Prompt for necessary permissions
echo ""
echo "================ IMPORTANT =================="
echo "For window management to work correctly, you need to:"
echo "1. Go to System Settings > Privacy & Security > Accessibility"
echo "2. Add and enable these applications:"
echo "   - $(which yabai)"
echo "   - $(which skhd)"
echo ""
echo "If services fail to start, you can manually start them after granting permissions:"
echo "  yabai --start-service"
echo "  skhd --start-service"
echo "============================================="

echo "Symlinks created successfully!"
