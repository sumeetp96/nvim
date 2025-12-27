vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.keymap.set

-- Reload config
map('n', '<leader>R', function()
  require('util.reload-config').reload()
end, { desc = 'Source nvim config' })

-- Keep visual selection when indenting
map('v', '>', '>gv')
map('v', '<', '<gv')

-- Clear search highlight
map('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlight' })

-- Move selected block up/down
map('v', 'J', ":m '>+1<cr>gv=gv")
map('v', 'K', ":m '<-2<cr>gv=gv")

-- Create/Close tabs
map('n', '<leader>tn', '<cmd>tabnew<cr>', { desc = 'New tab' })
map('n', '<leader>tc', '<cmd>tabclose<cr>', { desc = 'Close tab' })
map('n', '<leader>to', '<cmd>tabonly<cr>', { desc = 'Close other tabs' })

-- Navigate tabs
map('n', '<leader>tl', '<cmd>tabnext<cr>', { desc = 'Next tab' })
map('n', '<leader>th', '<cmd>tabprevious<cr>', { desc = 'Previous tab' })
map('n', '<Tab>', '<cmd>tabnext<cr>', { desc = 'Next tab' })
map('n', '<S-Tab>', '<cmd>tabprevious<cr>', { desc = 'Previous tab' })

-- Move tabs
map('n', '<leader>tmp', '<cmd>-tabmove<cr>', { desc = 'Move tab left' })
map('n', '<leader>tmn', '<cmd>+tabmove<cr>', { desc = 'Move tab right' })

-- Go to specific tab
map('n', '<leader>t1', '1gt', { desc = 'Go to tab 1' })
map('n', '<leader>t2', '2gt', { desc = 'Go to tab 2' })
map('n', '<leader>t3', '3gt', { desc = 'Go to tab 3' })
map('n', '<leader>t4', '4gt', { desc = 'Go to tab 4' })
map('n', '<leader>t5', '5gt', { desc = 'Go to tab 5' })

-- Window split
map('n', '<leader>-', '<cmd>split<cr><C-w>w', { desc = 'Split window vertically' })
map('n', '<leader>\\', '<cmd>vsplit<cr><C-w>w', { desc = 'Split window horizontally' })

-- Window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Navigate in tmux
map('n', '<C-h>', '<Cmd>TmuxNavigateLeft<CR>')
map('n', '<C-j>', '<Cmd>TmuxNavigateDown<CR>')
map('n', '<C-k>', '<Cmd>TmuxNavigateUp<CR>')
map('n', '<C-l>', '<Cmd>TmuxNavigateRight<CR>')

-- Resize windows
map('n', '<M-Up>', '<cmd>resize -2<cr>')
map('n', '<M-Down>', '<cmd>resize +2<cr>')
map('n', '<M-Left>', '<cmd>vertical resize -2<cr>')
map('n', '<M-Right>', '<cmd>vertical resize +2<cr>')

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
  require('util.toggle-bool').toggle_bool()
end, { desc = 'Toggle word to opposite' })

-- Debug Log
map('n', '<leader>l', function()
  require('util.debug-log').log_simple()
end, { desc = 'Debug log' })
map('v', '<leader>l', function()
  require('util.debug-log').log_simple()
end, { desc = 'Debug log (selection)' })
map('n', '<leader>L', function()
  require('util.debug-log').log_context()
end, { desc = 'Contextual log' })
map('v', '<leader>L', function()
  require('util.debug-log').log_context()
end, { desc = 'Contextual log (selection)' })

-- Undo tree
map('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = 'Undo tree' })

-- Lazygit
map('n', '<leader>gg', '<cmd>LazyGit<CR>', { desc = 'LazyGit' })
