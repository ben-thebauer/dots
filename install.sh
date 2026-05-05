#!/bin/bash

# Dotfiles install script
# Symlinks config files to $HOME, backing up existing ones

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d%H%M%S)"

echo "Dotfiles dir: $DOTFILES_DIR"
echo ""

# Files to symlink directly to $HOME
HOME_FILES=(".gitconfig")

# .config subdirs to symlink
CONFIG_DIRS=("nvim" "fish" "lazygit" "btop")

# .pi files to symlink (not the whole dir - excludes auth/sessions)
PI_FILES=(".pi/settings.json" ".pi/agent/settings.json")

# Backup and symlink a file/directory
backup_and_link() {
    local src="$1"
    local dest="$2"
    
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        if [ -L "$dest" ]; then
            echo "Removing existing symlink: $dest"
            rm "$dest"
        else
            echo "Backing up: $dest"
            mkdir -p "$BACKUP_DIR"
            mv "$dest" "$BACKUP_DIR/"
        fi
    fi
    
    echo "Linking: $dest -> $src"
    ln -s "$src" "$dest"
}

# Symlink files to $HOME
for file in "${HOME_FILES[@]}"; do
    backup_and_link "$DOTFILES_DIR/$file" "$HOME/$file"
done

# Symlink .ssh/config (create .ssh dir if needed)
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
if [ -f "$DOTFILES_DIR/.ssh/config" ]; then
    backup_and_link "$DOTFILES_DIR/.ssh/config" "$HOME/.ssh/config"
fi

# Symlink .config directories
mkdir -p "$HOME/.config"
for dir in "${CONFIG_DIRS[@]}"; do
    if [ -d "$DOTFILES_DIR/.config/$dir" ]; then
        backup_and_link "$DOTFILES_DIR/.config/$dir" "$HOME/.config/$dir"
    fi
done

# Symlink .pi config files (not auth/sessions)
mkdir -p "$HOME/.pi/agent"
for file in "${PI_FILES[@]}"; do
    if [ -f "$DOTFILES_DIR/$file" ]; then
        backup_and_link "$DOTFILES_DIR/$file" "$HOME/$file"
    fi
done

echo ""
echo "Done! Existing files backed up to: $BACKUP_DIR"
echo ""
echo "Post-install steps:"
echo "  1. Install fish:    sudo pacman -S fish (or apt install fish)"
echo "  2. Set as default:  chsh -s \$(which fish)"
echo "  3. Install neovim:  sudo pacman -S neovim (or apt install neovim)"
echo "  4. Install lazygit: sudo pacman -S lazygit (or add repo)"
echo "  5. Bootstrap nvim:  nvim (LazyVim will install plugins)"
echo "  6. Install pi:      npm install -g @mariozechner/pi-coding-agent"
echo "  7. Login to pi:     pi /login"
echo "  8. Generate SSH key or copy from secure location"
