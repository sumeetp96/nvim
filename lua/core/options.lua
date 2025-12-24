-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- UI
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'

-- Behavior
vim.opt.scrolloff = 8
vim.opt.clipboard = 'unnamedplus'
vim.opt.updatetime = 250
vim.g.disable_autoformat = false

-- Project local configs
vim.opt.exrc = true
vim.opt.secure = true

-- Allows @ in filenames
vim.opt.isfname:append('@-@')

-- Color column
-- vim.opt.colorcolumn = "80"

-- Undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('data') .. '/undo'
vim.g.undotree_WindowLayout = 2
vim.g.undotree_SplitWidth = 35
vim.g.undotree_DiffpanelHeight = 5

-- LazyGit
vim.g.lazygit_floating_window_winblend = 0
vim.g.lazygit_floating_window_scaling_factor = 1.0
vim.g.lazygit_use_neovim_remote = 1

