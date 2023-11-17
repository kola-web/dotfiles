#!/bin/zsh

# Configuration
export YABAI_CERT="yabai-cert"
YABAI_BIN="$(brew --prefix yabai)/bin/yabai"
YABAI_FORMULA="koekeishiya/formulae/yabai"

# Function to update sudoers file
function suyabai() {
    SHA256=$(shasum -a 256 "$(command -v yabai)" | awk '{print $1}')
    sudoers_file="/private/etc/sudoers.d/yabai"

    if [ -f "$sudoers_file" ]; then
        sudo sed -i '' -e "s/sha256:[[:alnum:]]*/sha256:${SHA256}/" "$sudoers_file"
        echo "sudoers > yabai > sha256 hash added"
    else
        echo "sudoers file does not exist yet"
    fi
}

# Unpin yabai from brew first
brew unpin yabai

# Update yabai
suyabai
yabai --stop-service
brew reinstall "$YABAI_FORMULA"
codesign -fs "${YABAI_CERT}" "$YABAI_BIN"
yabai --start-service

# Pin yabai back to brew
brew pin yabai

echo "Yabai update completed successfully."
