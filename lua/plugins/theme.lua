local themes = {
	rose_pine = "rose-pine",
	kanagawa = "kanagawa",
	everforest = "everforest",
	gruvbox_material = "gruvbox_material",
}

local active_theme = themes.rose_pine
local bg_transparent = false

return {
	--[[ Rose Pine ]]
	{
		enabled = active_theme == themes.rose_pine,
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "main", -- main | moon | dawn
				styles = {
					transparency = bg_transparent,
				},
			})
			vim.cmd("colorscheme rose-pine")
		end,
	},

	--[[ Kanagawa ]]
	{
		enabled = active_theme == themes.kanagawa,
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				theme = "dragon", -- wave | dragon | lotus
				transparency = bg_transparent,
			})
			vim.cmd("colorscheme kanagawa")
		end,
	},

	--[[ Everforest ]]
	{
		enabled = active_theme == themes.everforest,
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("everforest").setup({
				background = "medium", -- hard | medium | soft
				transparent_background_level = bg_transparent and 1 or 0,
			})
			vim.cmd.colorscheme("everforest")
		end,
	},

	--[[   Gruvbox Material ]]
	{
		enabled = active_theme == themes.gruvbox_material,
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_background = "hard" -- soft | medium | hard
			vim.g.gruvbox_material_foreground = "material" -- material | mix | original
			vim.g.gruvbox_material_better_performance = 1
			vim.g.gruvbox_material_transparent_background = bg_transparent and 1 or 0
			vim.g.gruvbox_material_enable_italic = 1
			vim.g.gruvbox_material_enable_bold = 1
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
}
