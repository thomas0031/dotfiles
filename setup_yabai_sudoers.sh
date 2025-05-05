#!/bin/bash

# Get the current username
CURRENT_USER=$(whoami)
YABAI_PATH=$(which yabai)

echo "Setting up sudoers file for yabai..."
echo "This will allow yabai to load its scripting addition without a password prompt."

# Create temp file
TMP_FILE=$(mktemp)
echo "${CURRENT_USER} ALL = (root) NOPASSWD: ${YABAI_PATH} --load-sa" > "$TMP_FILE"

# Check syntax
visudo -cf "$TMP_FILE"
if [ $? -ne 0 ]; then
  echo "Error: Invalid sudoers syntax."
  rm "$TMP_FILE"
  exit 1
fi

# Install the sudoers file
echo "Installing sudoers file..."
sudo cp "$TMP_FILE" "/private/etc/sudoers.d/yabai"
sudo chmod 0440 "/private/etc/sudoers.d/yabai"
rm "$TMP_FILE"

echo "Sudoers file installed successfully."
echo "You can now use 'sudo yabai --load-sa' without a password prompt."
