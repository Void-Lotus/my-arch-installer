#!/bin/bash
# 02-packages.sh - Install official pacman packages

LIST_FILE="packages/pacman-list.txt"

if [ ! -f "$LIST_FILE" ]; then
    echo "Package list $LIST_FILE not found!"
    exit 1
fi

echo "Reading package list..."
PACKAGES=()
while IFS= read -r pkg; do
    # Skip empty lines and comments
    [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
    PACKAGES+=("$pkg")
done < "$LIST_FILE"

if [ ${#PACKAGES[@]} -eq 0 ]; then
    echo "No packages found to install."
    exit 0
fi

echo "Installing official packages..."
sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"

# Enable PCSC daemon socket for CAC/smart card readers if ccid is installed
if pacman -Qq ccid &>/dev/null; then
    echo "Enabling pcscd.socket for CAC/smart card readers..."
    sudo systemctl enable --now pcscd.socket
fi

