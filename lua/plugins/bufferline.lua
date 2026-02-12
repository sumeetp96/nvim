return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
			{ "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" } },
			{ "<leader>bD", "<cmd>bdelete!<cr>", { desc = "Delete buffer (force)" } },
			{
				"<leader>bo",
				"<Cmd>BufferLineCloseOthers<CR>",
				desc = "Close other buffers",
			},
			{
				"<leader>bP",
				"<Cmd>BufferLineGroupClose ungrouped<CR>",
				desc = "Delete Non-Pinned Buffers",
			},
			{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
			{ "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Go to buffer 1" },
			{ "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Go to buffer 2" },
			{ "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Go to buffer 3" },
			{ "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Go to buffer 4" },
			{ "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Go to buffer 5" },
			{ "[b", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
			{ "]b", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
		},
		config = function()
			require("bufferline").setup({
				options = {
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
					end,

					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							text_align = "center",
							separator = true,
						},
					},

					hover = {
						enabled = true,
						delay = 200,
						reveal = { "close" },
					},

					sort_by = "insert_after_current",
				},
			})
		end,
	},
}
