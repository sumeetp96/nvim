return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Diagnostics
			vim.diagnostic.config({
				virtual_text = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.INFO] = " ",
						[vim.diagnostic.severity.HINT] = " ",
						-- [vim.diagnostic.severity.HINT] = '»',
					},
				},
				float = {
					border = "rounded",
					source = "if_many",
				},
			})

			-- Integrate with nvim-cmp
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.textDocument.semanticTokens = {
				multilineTokenSupport = true,
			}
			capabilities.textDocument.completion.completionItem = {
				snippetSupport = true,
			}

			vim.lsp.config("*", {
				capabilities = capabilities,
				root_markers = { ".git" },
			})

			vim.lsp.enable({
				"lua_ls",
				"ts_ls",
				"bashls",
				"jsonls",
			})
		end,
	},
}
