#!/bin/bash
# 06-themes.sh - GTK Themes and Icons

if [ -d configs/themes ]; then
    echo "Deploying custom themes and icons to home directory..."
    for item in configs/themes/*; do
        [ -e "$item" ] || continue
        name=$(basename "$item")
        target="$HOME/$name"
        
        # Merge or overwrite themes
        if [ -d "$target" ]; then
            cp -r "$item"/* "$target/"
        else
            cp -r "$item" "$target"
        fi
    done
fi
