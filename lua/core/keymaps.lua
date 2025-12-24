vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.keymap.set

-- Keep visual selection when indenting
map('v', '>', '>gv')
map('v', '<', '<gv')

-- Clear search highlight
map('n', '<leader>z', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlight' })

-- Move selected block up/down
map('v', 'J', ":m '>+1<cr>gv=gv")
map('v', 'K', ":m '<-2<cr>gv=gv")

-- Window split
map('n', '<leader>-', '<cmd>split<cr><C-w>w', { desc = 'Split window vertically' })
map('n', '<leader>\\', '<cmd>vsplit<cr><C-w>w', { desc = 'Split window horizontally' })

-- Window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Resize windows
map('n', '<C-Up>', '<cmd>resize -2<cr>')
map('n', '<C-Down>', '<cmd>resize +2<cr>')
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>')
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>')

-- Jump over references
map('n', ']]', '*', { desc = 'Jump to next match' })
map('n', '[[', '#', { desc = 'Jump to previous match' })

-- Open explorer
map('n', '<leader>pv', vim.cmd.Ex)

-- Join lines without losing cursor position
map('n', 'J', 'mzJ`z')

-- Half-page scroll, cursor centered
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- Search result centering
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- Disable Ex mode (ancient Vim)
map('n', 'Q', '<nop>')

-- Replace word under cursor
map(
  { 'n', 'v' },
  '<leader>r',
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]],
  { desc = 'Replace word under cursor' }
)

-- Delete without yanking
map('n', 'x', '"_x')

-- Increment/decrement numbers
map('n', '+', '<C-a>')
map('n', '-', '<C-x>')

-- Word toggles
map('n', '<leader>i', function()
  require('core.toggle').toggle_bool()
end, { desc = 'Toggle word to opposite' })

-- Navigate in tmux
map('n', '<C-h>', '<Cmd>TmuxNavigateLeft<CR>')
map('n', '<C-j>', '<Cmd>TmuxNavigateDown<CR>')
map('n', '<C-k>', '<Cmd>TmuxNavigateUp<CR>')
map('n', '<C-l>', '<Cmd>TmuxNavigateRight<CR>')

-- Quick log
map('n', '<leader>l', function()
  require('core.quicklog').log_simple()
end, { desc = 'Quick log' })
map('v', '<leader>l', function()
  require('core.quicklog').log_simple()
end, { desc = 'Quick log (selection)' })
map('n', '<leader>L', function()
  require('core.quicklog').log_context()
end, { desc = 'Contextual log' })
map('v', '<leader>L', function()
  require('core.quicklog').log_context()
end, { desc = 'Contextual log (selection)' })

-- Undo tree
map('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = 'Undo tree' })

-- Lazygit
map('n', '<leader>gg', '<cmd>LazyGit<CR>', { desc = 'LazyGit' })

-- Reload config
map('n', '<leader>so', function()
  require('core.reload').reload()
end, { desc = 'Reload Neovim config' })
