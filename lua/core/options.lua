vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
-- vim.opt.colorcolumn = "80"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 250

vim.opt.incsearch = true
vim.opt.cursorline = true

-- Allows @ in filenames
vim.opt.isfname:append("@-@")

-- Undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Project local configs
vim.opt.exrc = true
vim.opt.secure = true

-- Remove padding from right and bottom
vim.g.neovide_padding_right = 0
vim.g.neovide_padding_bottom = 0

-- Enable spell checker
vim.opt.spell = false
vim.opt.spelllang = "en_us"
