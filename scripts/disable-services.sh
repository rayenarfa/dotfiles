#!/bin/bash

echo "Disabling optional services..."

sudo systemctl disable --now bluetooth.service
sudo systemctl disable --now ananicy-cpp.service
sudo systemctl disable --now cachyos-rate-mirrors.timer
sudo systemctl disable --now NetworkManager-dispatcher.service
sudo systemctl disable --now nvidia-powerd.service
sudo systemctl disable --now switcheroo-control.service
sudo systemctl disable --now ufw.service

# Stop user services
systemctl --user disable --now arch-update-tray.service
systemctl --user disable --now p11-kit-server.socket

# Lower swap pressure permanently
echo "vm.swappiness=10" | sudo tee /etc/sysctl.d/99-swappiness.conf

echo "Applying power profile..."
powerprofilesctl set power-saver

echo "Disabled unnecessary services."
