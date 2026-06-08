#!/bin/bash
# 00-base.sh - System preparation

# Enable pacman color & parallel downloads
if grep -q "#Color" /etc/pacman.conf; then
    sudo sed -i 's/#Color/Color/' /etc/pacman.conf
fi
if grep -q "#ParallelDownloads" /etc/pacman.conf; then
    sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 10/' /etc/pacman.conf
fi

echo "Updating system packages..."
sudo pacman -Syu --noconfirm

# Install base-devel if not present
echo "Installing base-devel..."
sudo pacman -S --needed --noconfirm base-devel git wget curl
