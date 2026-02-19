return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		cmd = "RenderMarkdown",
		keys = {
			{ "<leader>m", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle markdown rendering" },
		},
		ft = { "markdown" },
		config = function()
			require("render-markdown").setup({
				completions = { lsp = { enabled = true } },
			})
		end,
	},
}
