return {
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },

					javascript = { "prettierd" },
					javascriptreact = { "prettierd" },
					typescript = { "prettierd" },
					typescriptreact = { "prettierd" },

					json = { "prettierd" },
					markdown = { "prettierd" },
					html = { "prettierd" },
					css = { "prettierd" },
					xml = { "prettierd" },

					sh = { "shfmt" },

					dockerfile = { "dockerfmt" },
					Dockerfile = { "dockerfmt" },

					yaml = { "yamlfmt" },
					yml = { "yamlfmt" },
				},
			})
		end,
	},
}
