return {
	{
		enabled = false,
		"tribela/transparent.nvim",
		event = "VimEnter",
		config = true,
		keys = {
			{ "<leader>it", "<cmd>TransparentToggle<cr>", desc = "Toggle transparency" },
		},
	},
}
