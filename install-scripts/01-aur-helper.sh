#!/bin/bash
# 01-aur-helper.sh - AUR configuration

if command -v yay &>/dev/null || command -v paru &>/dev/null; then
    echo "AUR Helper is already installed."
    exit 0
fi

# Prompt user for choice
CHOICE=$(whiptail --title "Select AUR Helper" --menu \
    "Choose which AUR Helper to install:" 12 50 2 \
    "yay" "Go-based AUR helper (Recommended)" \
    "paru" "Rust-based AUR helper" \
    3>&1 1>&2 2>&3)

if [ -z "$CHOICE" ]; then
    CHOICE="yay"
fi

echo "Installing $CHOICE..."
mkdir -p /tmp/aur-helper-build
cd /tmp/aur-helper-build || exit 1

if [ "$CHOICE" = "yay" ]; then
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin || exit 1
else
    git clone https://aur.archlinux.org/paru-bin.git
    cd paru-bin || exit 1
fi

makepkg -si --noconfirm
cd "$OLDPWD"
rm -rf /tmp/aur-helper-build
