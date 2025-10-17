#!/bin/bash
set -e

USERNAME="labsquire"  # Change this as needed: yoda, labsquire, or dlw-labsquire

echo "Creating user: $USERNAME"
useradd -m -s /bin/bash "$USERNAME"
usermod -aG sudo "$USERNAME"
echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME

echo "Installing base packages as $USERNAME"
apt update && apt install -y git curl unzip wget

# Set up SSH access
echo "Setting up SSH access for $USERNAME"
SSH_SRC="/home/ubuntu/.ssh"
SSH_DEST="/home/$USERNAME/.ssh"

if [[ -f "$SSH_SRC/authorized_keys" ]]; then
    mkdir -p "$SSH_DEST"
    cp "$SSH_SRC/authorized_keys" "$SSH_DEST/authorized_keys"
    chown -R $USERNAME:$USERNAME "$SSH_DEST"
    chmod 700 "$SSH_DEST"
    chmod 600 "$SSH_DEST/authorized_keys"
    echo "SSH access configured."
else
    echo "authorized_keys not found in $SSH_SRC, skipping SSH setup."
fi

echo " User $USERNAME created and configured. You can now SSH into the instance using their key."
