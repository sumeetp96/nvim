return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional icons
		},
		lazy = false, -- load immediately
		config = function()
			-- disable netrw
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			require("nvim-tree").setup({
				sort_by = "name",
				view = {
					width = 35,
					side = "right",
					preserve_window_proportions = true,
				},
				update_focused_file = {
					enable = true,
					update_root = true,
				},
				git = {
					enable = true,
					ignore = false,
				},
				filesystem_watchers = {
					enable = true,
				},
				filters = {
					dotfiles = false,
					custom = { ".git/" },
				},
			})

			vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
		end,
	},
}
