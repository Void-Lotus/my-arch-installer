#!/bin/bash
# 05-sddm.sh - Install and configure SDDM + theme

if ! pacman -Qq sddm &>/dev/null; then
    echo "Installing SDDM..."
    sudo pacman -S --noconfirm sddm
fi

# Copy SDDM Theme
if [ -d configs/sddm ]; then
    echo "Deploying SDDM theme..."
    sudo mkdir -p /usr/share/sddm/themes
    sudo rm -rf /usr/share/sddm/themes/simple_sddm_2
    sudo cp -r configs/sddm /usr/share/sddm/themes/simple_sddm_2
fi

# Configure SDDM theme setting
echo "Configuring SDDM default theme..."
sudo mkdir -p /etc/sddm.conf.d
sudo tee /etc/sddm.conf.d/kde_settings.conf >/dev/null <<EOF
[Theme]
Current=simple_sddm_2
EOF

# Enable SDDM Service
echo "Enabling SDDM service..."
sudo systemctl enable sddm.service
