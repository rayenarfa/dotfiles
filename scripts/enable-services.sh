#!/bin/bash

echo "Enabling services..."

sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now ananicy-cpp.service
sudo systemctl enable --now cachyos-rate-mirrors.timer
sudo systemctl enable --now NetworkManager-dispatcher.service
sudo systemctl enable --now nvidia-powerd.service
sudo systemctl enable --now switcheroo-control.service
sudo systemctl enable --now ufw.service

systemctl --user enable --now arch-update-tray.service
systemctl --user enable --now p11-kit-server.socket

echo "Restoring performance profile..."
powerprofilesctl set performance

echo "Services enabled."
