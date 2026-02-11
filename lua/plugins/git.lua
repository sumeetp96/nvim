return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, "Next Hunk")

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, "Previous Hunk")

				-- Actions
				map("n", "<leader>hs", gitsigns.stage_hunk, "Stage Hunk")
				map("n", "<leader>hr", gitsigns.reset_hunk, "Reset Hunk")

				map("v", "<leader>hs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Stage Hunk")

				map("v", "<leader>hr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Reset Hunk")

				map("n", "<leader>hS", gitsigns.stage_buffer, "Stage Buffer")
				map("n", "<leader>hR", gitsigns.reset_buffer, "Reset Buffer")
				map("n", "<leader>hp", gitsigns.preview_hunk, "Preview Hunk")
				map("n", "<leader>hi", gitsigns.preview_hunk_inline, "Preview Hunk Inline")

				map("n", "<leader>hb", function()
					gitsigns.blame_line({ full = true })
				end, "Blame Line")

				map("n", "<leader>hd", gitsigns.diffthis, "Diff Hunk")

				map("n", "<leader>hD", function()
					gitsigns.diffthis("~")
				end, "Diff Buffer")

				map("n", "<leader>hQ", function()
					gitsigns.setqflist("all")
				end, "Quick Fix list all")
				map("n", "<leader>hq", gitsigns.setqflist, "Quick Fix list")

				-- Toggles
				map("n", "<leader>tb", gitsigns.toggle_current_line_blame, "Toogle Blame Line")
				map("n", "<leader>tw", gitsigns.toggle_word_diff, "Toggle Word Diff")

				-- Text object
				map({ "o", "x" }, "ih", gitsigns.select_hunk, "Select Hunk")
			end,
		},
	},
}
