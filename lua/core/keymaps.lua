vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

map("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw explorer" })

-- Disable Ex mode
map("n", "Q", "<nop>")

-- Fix C-i not working
map("n", "<C-i>", "<C-i>", { noremap = true })

-- Current file operations
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- Manually clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Keep visual selection when indenting
map("v", ">", ">gv", { desc = "Indent right" })
map("v", "<", "<gv", { desc = "Indent left" })

-- Move selected block up/down
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better paste (doesn't replace clipboard)
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Join lines without losing cursor position
map("n", "J", "mzJ`z", { desc = "Join lines" })

-- Half-page scroll, cursor centered
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })

-- Search result centering
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Jump over references
map("n", "]]", "*", { desc = "Jump to next match" })
map("n", "[[", "#", { desc = "Jump to previous match" })

-- Delete without yanking
map("n", "x", '"_x', { desc = "Delete char without yank" })

-- Increment/decrement numbers
map("n", "+", "<C-a>", { desc = "Increment number" })
map("n", "-", "<C-x>", { desc = "Decrement number" })

-- Toggle spell check
map("n", "<leader>sc", function()
	vim.wo.spell = not vim.wo.spell
	if vim.wo.spell then
		print("Spell check enabled")
	else
		print("Spell check disabled")
	end
end, { desc = "Toggle spell check" })

-- ============================
-- WINDOW MANAGEMENT
-- ============================

-- Split windows
map("n", "<leader>-", "<cmd>split<cr><C-w>w", { desc = "Split horizontally" })
map("n", "<leader>\\", "<cmd>vsplit<cr><C-w>w", { desc = "Split vertically" })

map("n", "<leader>wc", "<cmd>close<cr>", { desc = "Close window" })
map("n", "<leader>wo", "<cmd>only<cr>", { desc = "Close other windows" })

-- Navigate windows (works with tmux)
map("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { desc = "Go to left window" })
map("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { desc = "Go to lower window" })
map("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { desc = "Go to upper window" })
map("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { desc = "Go to right window" })

-- Resize windows
map("n", "<M-Up>", "<cmd>resize -1<cr>", { desc = "Decrease window height" })
map("n", "<M-Down>", "<cmd>resize +3<cr>", { desc = "Increase window height" })
map("n", "<M-Left>", "<cmd>vertical resize -1<cr>", { desc = "Decrease window width" })
map("n", "<M-Right>", "<cmd>vertical resize +3<cr>", { desc = "Increase window width" })

-- Equalize windows
map("n", "<leader>w=", "<C-w>=", { desc = "Equalize window sizes" })

-- ============================
-- TAB MANAGEMENT
-- ============================

-- Create/Close tabs
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Close other tabs" })

-- Navigate tabs
map("n", "<leader>tl", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<leader>th", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
map("n", "<Tab>", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<S-Tab>", "<cmd>tabprevious<cr>", { desc = "Previous tab" })

-- Move tabs
map("n", "<leader>tmp", "<cmd>-tabmove<cr>", { desc = "Move tab left" })
map("n", "<leader>tmn", "<cmd>+tabmove<cr>", { desc = "Move tab right" })

-- Go to specific tab
map("n", "<M-1>", "1gt", { desc = "Go to tab 1" })
map("n", "<M-2>", "2gt", { desc = "Go to tab 2" })
map("n", "<M-3>", "3gt", { desc = "Go to tab 3" })
map("n", "<M-4>", "4gt", { desc = "Go to tab 4" })
map("n", "<M-5>", "5gt", { desc = "Go to tab 5" })
