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

# Ask user if they want to install CAC/Smart Card dependencies
INSTALL_CAC=false
if whiptail --title "CAC/Smart Card Support" --yesno "Would you like to install CAC/Smart Card reader dependencies (ccid, opensc, pcsc-tools, etc.)?" 10 65; then
    echo "Adding CAC dependencies to package list..."
    PACKAGES+=("ccid" "opensc" "pcsc-perl" "pcsc-tools" "lib32-pcsclite")
    INSTALL_CAC=true
else
    echo "Skipping CAC dependencies."
fi

echo "Installing official packages..."
sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"

# Enable PCSC daemon socket if CAC packages were chosen
if [ "$INSTALL_CAC" = true ]; then
    echo "Enabling pcscd.socket for CAC/smart card readers..."
    sudo systemctl enable --now pcscd.socket
fi


