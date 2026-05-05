if status is-interactive
    if not set -q SSH_AUTH_SOCK; or not test -S $SSH_AUTH_SOCK
        eval (ssh-agent -c) > /dev/null
    end
    ssh-add -l > /dev/null 2>&1; or ssh-add ~/.ssh/git_id_ed25519 2>/dev/null
end
export PATH="$HOME/.local/bin:$PATH"

# Neovim config switching
alias nvim-old 'NVIM_APPNAME=nvim-old nvim'
alias vim 'nvim'
alias vi 'nvim'
