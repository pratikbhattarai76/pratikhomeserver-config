#!/bin/bash

set -e 

echo "--- 1. System Updates ---"
sudo apt update && sudo apt upgrade -y

echo "--- 2. Docker Installation ---"
if ! [ -x "$(command -v docker)" ]; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
fi

# Enable Docker at boot
sudo systemctl enable --now docker

echo "--- 3. Nvidia & Gpu Setup ---"
# Install Drivers
if ! [ -x "$(command -v nvidia-smi)" ]; then
    sudo ubuntu-drivers install
fi

# Install NVIDIA Container Toolkit
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

echo "--- 4. Cloudflared Setup ---"
if ! [ -x "$(command -v cloudflared)" ]; then
    wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
    sudo dpkg -i cloudflared-linux-amd64.deb
    rm cloudflared-linux-amd64.deb
fi

echo "If this is first time, run:"
echo "cloudflared tunnel login"

# Install Cloudflared as a system service 
echo "To install tunnel as service after creating it:"
echo "cloudflared service install"
echo "Then enable it with:"
echo "sudo systemctl enable cloudflared"

echo "--- 5. Immutable Storage ---"
UUID="4250e634-f248-4591-b2b0-6d12919f6c8e"
MOUNT_POINT="/mnt/storage"
if ! grep -q "$UUID" /etc/fstab; then
    sudo mkdir -p $MOUNT_POINT
    echo "UUID=$UUID $MOUNT_POINT ext4 defaults,nofail 0 2" | sudo tee -a /etc/fstab
    sudo mount -a
fi

echo "--- Setup Complete ---"
echo "Next Steps:"
echo "1. Run: cloudflared tunnel login"
echo "2. Create tunnel: cloudflared tunnel create pratikhomeserver(tunnel name)"
echo "3. Move your config.yml to ~/.cloudflared/config.yml"
echo "4. Install service: sudo cloudflared service install"


