#!/bin/bash
# 03-aur-packages.sh - Install AUR packages

LIST_FILE="packages/aur-list.txt"

if [ ! -f "$LIST_FILE" ]; then
    echo "AUR package list $LIST_FILE not found!"
    exit 1
fi

HELPER=""
if command -v yay &>/dev/null; then
    HELPER="yay"
elif command -v paru &>/dev/null; then
    HELPER="paru"
else
    echo "Neither yay nor paru is installed! Cannot install AUR packages."
    exit 1
fi

echo "Reading AUR package list..."
PACKAGES=()
while IFS= read -r pkg; do
    [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
    PACKAGES+=("$pkg")
done < "$LIST_FILE"

if [ ${#PACKAGES[@]} -eq 0 ]; then
    echo "No AUR packages found to install."
    exit 0
fi

echo "Installing AUR packages using $HELPER..."
$HELPER -S --needed --noconfirm "${PACKAGES[@]}"
