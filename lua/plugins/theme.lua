local themes = {
	rose_pine = "rose-pine",
	kanagawa = "kanagawa",
	everforest = "everforest",
	gruvbox_material = "gruvbox_material",
}

local active_theme = themes.rose_pine

return {
	--[[ Rose Pine ]]
	{
		enabled = active_theme == themes.rose_pine,
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "moon", -- main | moon | dawn
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
			vim.g.gruvbox_material_enable_italic = 1
			vim.g.gruvbox_material_enable_bold = 1
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
}
