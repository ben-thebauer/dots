vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("config.lazy")

-- vim.g.have_nerd_font = true

vim.o.mouse = 'a'

vim.o.number = true
vim.o.relativenumber = true

-- scheduled after ui enter b/c it can increase startup time
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- keep indent level on newline
vim.o.breakindent = true

vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

-- preview %s substitutions while typing
vim.o.inccommand = 'split'

vim.o.cursorline = true

vim.o.confirm = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
