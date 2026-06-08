#!/bin/bash
# 04-dotfiles.sh - Deploy configurations

BACKUP_TIME=$(date +%Y%m%d_%H%M%S)

# Deploy ~/.config files
if [ -d configs/dotfiles ]; then
    echo "Deploying dotfiles to ~/.config..."
    mkdir -p "$HOME/.config"
    for item in configs/dotfiles/*; do
        [ -e "$item" ] || continue
        name=$(basename "$item")
        target="$HOME/.config/$name"
        
        if [ -e "$target" ] || [ -L "$target" ]; then
            echo "Backing up existing: ~/.config/$name -> ~/.config/${name}.bak-$BACKUP_TIME"
            mv "$target" "${target}.bak-$BACKUP_TIME"
        fi
        cp -r "$item" "$target"
    done
fi

# Deploy Shell profile configs
if [ -d configs/shell_configs ]; then
    echo "Deploying shell profiles to ~..."
    for item in configs/shell_configs/*; do
        [ -e "$item" ] || continue
        name=$(basename "$item")
        target="$HOME/$name"
        
        if [ -e "$target" ] || [ -L "$target" ]; then
            echo "Backing up existing: ~/$name -> ~/${name}.bak-$BACKUP_TIME"
            mv "$target" "${target}.bak-$BACKUP_TIME"
        fi
        cp -r "$item" "$target"
    done
fi

# Deploy Wallpapers
if [ -d configs/wallpapers ]; then
    echo "Deploying wallpapers..."
    mkdir -p "$HOME/Pictures/wallpapers"
    cp -r configs/wallpapers/* "$HOME/Pictures/wallpapers/"
fi
