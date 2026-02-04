vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.keymap.set

-- ============================
-- GENERAL UTILITIES
-- ============================

-- Reload config
map('n', '<leader>R', function()
  require('util.reload-config').reload() -- safer
end, { desc = 'Source nvim config' })

-- Clear search highlight
map('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlight' })

-- Select all
map('n', '<C-a>', 'gg<S-v>G', { desc = 'Select all' })

-- Disable Ex mode
map('n', 'Q', '<nop>')

-- ============================
-- VISUAL MODE ENHANCEMENTS
-- ============================

-- Keep visual selection when indenting
map('v', '>', '>gv', { desc = 'Indent right' })
map('v', '<', '<gv', { desc = 'Indent left' })

-- Move selected block up/down
map('v', 'J', ":m '>+1<cr>gv=gv", { desc = 'Move selection down' })
map('v', 'K', ":m '<-2<cr>gv=gv", { desc = 'Move selection up' })

-- Better paste (doesn't replace clipboard)
map('v', 'p', '"_dP', { desc = 'Paste without yanking' })

-- ============================
-- NORMAL MODE ENHANCEMENTS
-- ============================

-- Join lines without losing cursor position
map('n', 'J', 'mzJ`z', { desc = 'Join lines' })

-- Half-page scroll, cursor centered
map('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down (centered)' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up (centered)' })

-- Search result centering
map('n', 'n', 'nzzzv', { desc = 'Next search result (centered)' })
map('n', 'N', 'Nzzzv', { desc = 'Previous search result (centered)' })

-- Jump over references
map('n', ']]', '*', { desc = 'Jump to next match' })
map('n', '[[', '#', { desc = 'Jump to previous match' })

-- Delete without yanking
map('n', 'x', '"_x', { desc = 'Delete char without yank' })

-- Increment/decrement numbers
map('n', '+', '<C-a>', { desc = 'Increment number' })
map('n', '-', '<C-x>', { desc = 'Decrement number' })

-- Replace word under cursor
map(
  { 'n', 'v' },
  '<leader>r',
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]],
  { desc = 'Replace word under cursor' }
)

-- ============================
-- TAB MANAGEMENT
-- ============================

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
map('n', '<M-1>', '1gt', { desc = 'Go to tab 1' })
map('n', '<M-2>', '2gt', { desc = 'Go to tab 2' })
map('n', '<M-3>', '3gt', { desc = 'Go to tab 3' })
map('n', '<M-4>', '4gt', { desc = 'Go to tab 4' })
map('n', '<M-5>', '5gt', { desc = 'Go to tab 5' })

-- ============================
-- WINDOW MANAGEMENT
-- ============================

-- Split windows
map('n', '<leader>-', '<cmd>split<cr><C-w>w', { desc = 'Split horizontally' })
map('n', '<leader>\\', '<cmd>vsplit<cr><C-w>w', { desc = 'Split vertically' })
map('n', '<leader>wc', '<cmd>close<cr>', { desc = 'Close window' })
map('n', '<leader>wo', '<cmd>only<cr>', { desc = 'Close other windows' })

-- Navigate windows (works with tmux)
map('n', '<C-h>', '<Cmd>TmuxNavigateLeft<CR>', { desc = 'Go to left window' })
map('n', '<C-j>', '<Cmd>TmuxNavigateDown<CR>', { desc = 'Go to lower window' })
map('n', '<C-k>', '<Cmd>TmuxNavigateUp<CR>', { desc = 'Go to upper window' })
map('n', '<C-l>', '<Cmd>TmuxNavigateRight<CR>', { desc = 'Go to right window' })

-- Resize windows
map('n', '<M-Up>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
map('n', '<M-Down>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
map('n', '<M-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
map('n', '<M-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

-- Equalize windows
map('n', '<leader>w=', '<C-w>=', { desc = 'Equalize window sizes' })

-- ============================
-- BUFFER MANAGEMENT
-- ============================

-- Navigate buffers
map('n', '<leader>bn', '<cmd>bnext<cr>', { desc = 'Next buffer' })
map('n', '<leader>bp', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
map('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Delete buffer' })
map(
  'n',
  '<leader>bD',
  '<cmd>%bdelete|edit#|bdelete#<cr>',
  { desc = 'Delete all buffers except current' }
)

-- Alternative buffer navigation
map('n', 'H', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
map('n', 'L', '<cmd>bnext<cr>', { desc = 'Next buffer' })

-- ============================
-- FILE EXPLORER
-- ============================

map('n', '<leader>pv', vim.cmd.Ex, { desc = 'Open netrw explorer' })

-- ============================
-- TERMINAL MODE
-- ============================

map('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Terminal: Go to left window' })
map('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Terminal: Go to lower window' })
map('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Terminal: Go to upper window' })
map('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Terminal: Go to right window' })
map('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- ============================
-- QUICKFIX LIST
-- ============================

map('n', '<leader>xq', '<cmd>copen<cr>', { desc = 'Open quickfix list' })
map('n', '<leader>xc', '<cmd>cclose<cr>', { desc = 'Close quickfix list' })
map('n', ']q', '<cmd>cnext<cr>', { desc = 'Next quickfix item' })
map('n', '[q', '<cmd>cprev<cr>', { desc = 'Previous quickfix item' })

-- ============================
-- CUSTOM UTILITIES
-- ============================

-- Word toggles (true/false, yes/no, etc.)
map('n', '<leader>i', function()
  require('util.toggle-bool').toggle_bool()
end, { desc = 'Toggle word to opposite' })

-- Debug logging
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

-- ============================
-- PLUGIN SPECIFIC
-- ============================

-- Undo tree
map('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = 'Undo tree' })

-- LazyGit
map('n', '<leader>gg', '<cmd>LazyGit<CR>', { desc = 'LazyGit' })
