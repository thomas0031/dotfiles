#!/bin/bash

echo "Setting up yabai scripting addition..."

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root."
  echo "Please run: sudo ./setup_yabai_scripting_addition.sh"
  exit 1
fi

# Load the scripting addition
yabai --load-sa

echo "Scripting addition loaded successfully!"
echo "You may need to run this script again after system updates or reboots."
