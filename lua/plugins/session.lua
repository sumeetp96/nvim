return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {
		dir = vim.fn.stdpath("state") .. "/sessions/",
		options = { "buffers", "curdir", "tabpages", "winsize" },
	},
	keys = {
		{
			"<leader>sr",
			function()
				require("persistence").load()
			end,
			desc = "Restore session",
		},
		{
			"<leader>sl",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "Restore last session",
		},
		{
			"<leader>sd",
			function()
				require("persistence").stop()
			end,
			desc = "Disable session",
		},
	},
}
