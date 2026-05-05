# Dotfiles

Personal dotfiles for core dev environment setup.

## What's Included

- **nvim** - LazyVim configuration
- **fish** - Shell config, functions, and custom prompt
- **pi** - Coding agent settings (packages, provider, model)
- **git** - Global gitconfig
- **ssh** - SSH config (host aliases, not keys)
- **lazygit** - Terminal git UI config
- **btop** - System monitor config

## Quick Start

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles

# Run the install script
cd ~/dotfiles
./install.sh
```

The install script will:
- Back up any existing configs to `~/.dotfiles-backup-<timestamp>`
- Create symlinks from `~/dotfiles` to your home directory

## Post-Install

1. **Install fish shell**
   ```bash
   # Arch
   sudo pacman -S fish
   
   # Debian/Ubuntu
   sudo apt install fish
   
   # Set as default shell
   chsh -s $(which fish)
   ```

2. **Install neovim** (v0.9+ required for LazyVim)
   ```bash
   # Arch
   sudo pacman -S neovim
   
   # Debian/Ubuntu - use appimage or PPA for latest version
   ```

3. **Install lazygit**
   ```bash
   # Arch
   sudo pacman -S lazygit
   
   # Debian/Ubuntu
   sudo add-apt-repository ppa:lazygit-team/release
   sudo apt update && sudo apt install lazygit
   ```

4. **Bootstrap neovim** - Just run `nvim`, LazyVim will install plugins automatically

5. **Install pi** - Coding agent harness
   ```bash
   npm install -g @mariozechner/pi-coding-agent
   pi /login  # Authenticate with your provider
   ```

6. **SSH keys** - Generate new ones or copy from secure storage:
   ```bash
   ssh-keygen -t ed25519 -C "your@email.com" -f ~/.ssh/git_id_ed25519
   ```

## Structure

```
~/dotfiles/
├── .config/
│   ├── nvim/       # LazyVim config
│   ├── fish/       # Shell config
│   ├── lazygit/    # Git TUI config
│   └── btop/       # System monitor
├── .pi/
│   ├── settings.json       # Pi packages
│   └── agent/
│       └── settings.json   # Provider/model config
├── .ssh/
│   └── config      # Host aliases (no keys!)
├── .gitconfig      # Git settings
├── install.sh      # Symlink installer
└── README.md
```

## Notes

- SSH keys are NOT included - generate new ones per machine
- Pi auth is NOT included - run `pi /login` after install
- Fish plugins will sync automatically via fisher on first run
- Local machine overrides can go in `~/.gitconfig.local` (add to .gitignore if needed)

## exe.dev VMs

To spin up a new VM with these dotfiles pre-installed:

```bash
# One-off VM
cat exe-setup.sh | ssh exe.dev new --setup-script /dev/stdin

# Set as default for all new VMs
# (run this once to save the default)
cat exe-setup.sh | ssh exe.dev defaults write dev.exe new.setup-script

# Then just create VMs normally
ssh exe.dev new --name myvm

# Clear the default when done
ssh exe.dev defaults delete dev.exe new.setup-script
```

The setup script installs: fish, neovim, lazygit, btop, node, pi, and clones/applies these dotfiles. Just run `pi /login` after SSHing in.
