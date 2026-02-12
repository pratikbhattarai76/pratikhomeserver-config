#!/bin/bash

set -e 

echo "--- System Updates ---"
sudo apt update && sudo apt upgrade -y

echo "--- Docker Installation ---"
if ! [ -x "$(command -v docker)" ]; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
fi

echo "--- Nvidia & Gpu Setup ---"
# Install Drivers
if ! [ -x "$(command -v nvidia-smi)" ]; then
    sudo ubuntu-drivers install
fi

# Install NVIDIA Container Toolkit (The Professional standard for AI/Transcoding)
if ! [ -x "$(command -v nvidia-ctk)" ]; then
    curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
    curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
    sudo apt update
    sudo apt install -y nvidia-container-toolkit
    sudo nvidia-ctk runtime configure --runtime=docker
    sudo systemctl restart docker
fi

echo "--- Immutable Storage ---"
UUID="4250e634-f248-4591-b2b0-6d12919f6c8e"
if ! grep -q "$UUID" /etc/fstab; then
    sudo mkdir -p /mnt/storage
    echo "UUID=$UUID /mnt/storage ext4 defaults,nofail 0 2" | sudo tee -a /etc/fstab
    sudo mount -a
fi

echo "--- Setup Complete ---"
echo "Please reboot with: sudo reboot"
