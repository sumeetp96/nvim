return {
  {
    'nvim-telescope/telescope.nvim', tag = 'v0.2.0',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({
        defaults = {
          layout_strategy = "flex",
          layout_config = {
            flex = {
              flip_columns = 120, -- switch to vertical when wide
            },
            horizontal = {
              preview_width = 0.6,
              width = 0.99,
              height = 0.99,
            },
            vertical = {
              preview_height = 0.6,
              width = 0.99,
              height = 0.99,
            },
          },
          preview = {
            hide_on_startup = false,
          },
          preview_cutoff = 1, -- NEVER hide preview
          prompt_position = "top",
          sorting_strategy = "ascending",
          winblend = 0,
          border = true,

          file_ignore_patterns = {
            "node_modules",
            "dist",
            "build",
            ".git/",
            ".next",
            "coverage",
          }
        }
      })

      local map = vim.keymap.set
      local tb = require('telescope.builtin')

      map('n', '<leader>ff', tb.find_files, { desc = 'Telescope find files' })
      map('n', '<leader>fg', tb.live_grep, { desc = 'Telescope live grep' })
      map('n', '<leader><leader>', tb.buffers, { desc = 'Telescope buffers' })
      map('n', '<leader>fh', tb.help_tags, { desc = 'Telescope help tags' })
      map('n', '<leader>fk', tb.keymaps, { desc = 'Telescope find keymaps' })
      map("n", "<leader>fw", function() tb.grep_string({ search = vim.fn.expand("<cword>") }) end, { desc = "Search word under cursor" })
      map('n', '<leader>sd', tb.diagnostics, { desc = '[S]earch [D]iagnostics' })
      map('n', '<leader>sr', tb.resume, { desc = '[S]earch [R]esume' })
      map('n', '<leader>s.', tb.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      map('n', '<leader><leader>', tb.buffers, { desc = '[ ] Find existing buffers' })
      map("n", "<leader>gc", tb.git_commits, { desc = "Git commits" })
      map("n", "<leader>gb", tb.git_branches, { desc = "Git branches" })
      map("n", "<leader>gs", tb.git_status, { desc = "Git status" })
      map("n", "<leader>sd", tb.lsp_definitions, { desc = "Symbol definitions" })
      map("n", "<leader>sr", tb.lsp_references, { desc = "Symbol references" })
      map("n", "<leader>si", tb.lsp_implementations, { desc = "Implementations" })
      map("n", "<leader>st", tb.lsp_type_definitions, { desc = "Type definitions" })
      map("n", "<leader>ss", tb.lsp_document_symbols, { desc = "Document symbols" })
      map("n", "<leader>sS", tb.lsp_workspace_symbols, { desc = "Workspace symbols" })
    end
  }
}
