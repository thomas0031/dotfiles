#!/bin/bash

echo "Checking window management configuration..."
echo ""

# Check if yabai and skhd are installed
if command -v yabai &> /dev/null; then
  echo "✅ yabai is installed: $(which yabai)"
  echo "   Version: $(yabai --version)"
else
  echo "❌ yabai is not installed"
fi

if command -v skhd &> /dev/null; then
  echo "✅ skhd is installed: $(which skhd)"
  echo "   Version: $(skhd --version)"
else
  echo "❌ skhd is not installed"
fi

echo ""
echo "Checking services status:"

# Check if services are running using the native commands
if yabai --check-service &>/dev/null; then
  echo "✅ yabai service is running"
else
  echo "❌ yabai service is not running"
  echo "   Start with: yabai --start-service"
fi

if skhd --check-service &>/dev/null; then
  echo "✅ skhd service is running"
else
  echo "❌ skhd service is not running"
  echo "   Start with: skhd --start-service"
fi

echo ""
echo "Checking configuration files:"

# Check if config files exist and have correct permissions
if [ -f "$HOME/.config/yabai/yabairc" ]; then
  echo "✅ yabairc exists"
  if [ -x "$HOME/.config/yabai/yabairc" ]; then
    echo "✅ yabairc is executable"
  else
    echo "❌ yabairc is not executable"
    echo "   Fix with: chmod +x ~/.config/yabai/yabairc"
  fi
else
  echo "❌ yabairc does not exist at ~/.config/yabai/yabairc"
fi

if [ -f "$HOME/.config/skhd/skhdrc" ]; then
  echo "✅ skhdrc exists"
else
  echo "❌ skhdrc does not exist at ~/.config/skhd/skhdrc"
fi

echo ""
echo "For more detailed troubleshooting, you can check the logs:"
echo "  skhd --version"
echo "  yabai --version"
echo "  yabai --verbose-logging"
