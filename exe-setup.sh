#!/bin/bash
# exe.dev VM setup script - runs on first boot
# Usage: cat exe-setup.sh | ssh exe.dev new --setup-script /dev/stdin

set -e

export DEBIAN_FRONTEND=noninteractive

echo "=== Installing dependencies ==="
sudo apt-get update
sudo apt-get install -y \
  fish \
  neovim \
  git \
  curl \
  unzip \
  btop \
  fzf \
  ripgrep \
  fd-find

echo "=== Installing lazygit ==="
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar -xzf /tmp/lazygit.tar.gz -C /tmp
sudo mv /tmp/lazygit /usr/local/bin
rm /tmp/lazygit.tar.gz

echo "=== Installing Node.js (for pi) ==="
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -
sudo apt-get install -y nodejs

echo "=== Installing pi ==="
sudo npm install -g @mariozechner/pi-coding-agent

echo "=== Installing fisher ==="
RUNUSER="exedev"
if id "ubuntu" &>/dev/null; then
  RUNUSER="ubuntu"
fi

runuser -u $RUNUSER -- fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'

echo "=== Cloning dotfiles ==="
runuser -u $RUNUSER -- git clone https://github.com/ben-thebauer/dots.git /home/$RUNUSER/dotfiles

echo "=== Running dotfiles install ==="
cd /home/$RUNUSER/dotfiles
runuser -u $RUNUSER -- ./install.sh

echo "=== Setting fish as default shell for $RUNUSER ==="
sudo chsh -s $(which fish) $RUNUSER

echo "=== Setup complete! ==="
echo "Login with: ssh exe.dev ssh <vmname>"
echo "Then run: pi /login"
