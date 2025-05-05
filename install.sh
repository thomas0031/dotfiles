#!/bin/bash
set -e

echo "Setting up your Mac..."

# Install Xcode Command Line Tools if not installed
if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "Please wait for Xcode Command Line Tools to install and press any key to continue..."
  read -n 1
fi

# Install Homebrew if not installed
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Add Homebrew to PATH for Apple Silicon Macs
  if [[ $(uname -m) == 'arm64' ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

# Update Homebrew
echo "Updating Homebrew..."
brew update

# Install everything from Brewfile
echo "Installing applications from Brewfile..."
brew bundle

# Install Oh-My-Zsh if you use it
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh-My-Zsh..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Set ZSH as default shell if it isn't already
if [[ "$SHELL" != *"zsh"* ]]; then
  echo "Setting zsh as default shell..."
  chsh -s "$(which zsh)"
fi

# Run the stow command to create symlinks
echo "Setting up dotfiles..."
./setup_symlinks.sh

# Setup window manager
echo "Setting up window manager..."
./setup_window_manager.sh

echo "Installation complete! 🚀"
echo "Please restart your terminal or run 'source ~/.zshrc' to apply changes."
