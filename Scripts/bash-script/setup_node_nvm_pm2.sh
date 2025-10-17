#!/bin/bash

set -e

echo " Updating packages..."
sudo apt update && sudo apt upgrade -y

echo " Installing required packages..."
sudo apt install -y curl wget build-essential git

echo " Installing NVM..."
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# Load NVM in this script
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

echo " Installing latest LTS version of Node.js via NVM..."
nvm install --lts
nvm use --lts
nvm alias default 'lts/*'

# Get full path to installed binaries
NODE_BIN_DIR=$(nvm which current | xargs dirname)

echo " Forcing Node, NPM, PM2 global system-wide symlinks..."
sudo ln -sf "$NODE_BIN_DIR/node" /usr/local/bin/node
sudo ln -sf "$NODE_BIN_DIR/npm" /usr/local/bin/npm
sudo ln -sf "$NODE_BIN_DIR/npx" /usr/local/bin/npx

echo " Installing PM2 globally via NPM..."
npm install -g pm2

# Re-resolve path to PM2 after install
PM2_PATH="$NODE_BIN_DIR/pm2"
sudo ln -sf "$PM2_PATH" /usr/local/bin/pm2

echo " Setting up PM2 startup service..."
pm2 startup systemd -u "$USER" --hp "$HOME" | grep sudo | bash

echo " Saving PM2 process list..."
pm2 save

echo " Done!"
echo "🧪 Verifying:"
echo "Node: $(/usr/local/bin/node -v)"
echo "NPM:  $(/usr/local/bin/npm -v)"
echo "PM2:  $(/usr/local/bin/pm2 -v)"
