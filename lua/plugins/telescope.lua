return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		-- File pickers
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{
			"<leader>fa",
			"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>",
			desc = "Find All Files (hidden)",
		},
		{ "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },

		-- Search pickers
		{ "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
		{ "<leader>fW", "<cmd>Telescope grep_string<cr>", desc = "Grep Word Under Cursor" },
		{ "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in Buffer" },

		-- LSP pickers
		{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
		{ "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
		{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
		{ "<leader>fi", "<cmd>Telescope lsp_implementations<cr>", desc = "Implementations" },
		{ "<leader>fD", "<cmd>Telescope lsp_definitions<cr>", desc = "Definitions" },
		{ "<leader>fR", "<cmd>Telescope lsp_references<cr>", desc = "References" },

		-- Git pickers
		{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
		{ "<leader>gC", "<cmd>Telescope git_bcommits<cr>", desc = "Buffer Commits" },
		{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },
		{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
		{ "<leader>gS", "<cmd>Telescope git_stash<cr>", desc = "Git Stash" },

		-- Vim pickers
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
		{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
		{ "<leader>fC", "<cmd>Telescope colorscheme<cr>", desc = "Colorschemes" },
		{ "<leader>fH", "<cmd>Telescope highlights<cr>", desc = "Highlight Groups" },
		{ "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Marks" },
		{ "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
		{ "<leader>fo", "<cmd>Telescope vim_options<cr>", desc = "Vim Options" },
		{ "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
		{ "<leader>fl", "<cmd>Telescope loclist<cr>", desc = "Location List" },

		-- Telescope built-ins
		{ "<leader>ft", "<cmd>Telescope builtin<cr>", desc = "Telescope Builtins" },
		{ "<leader>f?", "<cmd>Telescope resume<cr>", desc = "Resume Last Picker" },
	},

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				prompt_prefix = "❯ ",
				selection_caret = "➤ ",

				path_display = { "truncate" },
				file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/" },

				sorting_strategy = "ascending",

				layout_strategy = "horizontal",
				layout_config = {
					width = 0.99,
					height = 0.99,
					horizontal = {
						prompt_position = "top",
						preview_width = 0.6,
					},
					vertical = {
						prompt_position = "top",
						preview_width = 0.6,
					},
				},

				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					},
				},
			},

			pickers = {
				find_files = {
					theme = "dropdown",
					previewer = false,
					layout_config = {
						width = 0.8,
						height = 0.6,
					},
				},
				buffers = {
					theme = "dropdown",
					previewer = false,
					layout_config = {
						width = 0.8,
						height = 0.6,
					},
					initial_mode = "normal",
					mappings = {
						n = { ["dd"] = actions.delete_buffer },
					},
				},
			},

			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		telescope.load_extension("fzf")
	end,
}
