return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope', -- Load on command
  dependencies = {
    'nvim-lua/plenary.nvim', -- Required dependency

    -- FZF native sorter for better performance (optional but recommended)
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },

  keys = {
    -- File pickers
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
    { '<leader>fg', '<cmd>Telescope git_files<cr>', desc = 'Find Git Files' },
    { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent Files' },

    -- Search pickers
    { '<leader>fw', '<cmd>Telescope live_grep<cr>', desc = 'Find Word (Live Grep)' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Find Buffers' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help Tags' },

    -- LSP pickers
    { '<leader>fs', '<cmd>Telescope lsp_document_symbols<cr>', desc = 'Document Symbols' },
    { '<leader>fS', '<cmd>Telescope lsp_workspace_symbols<cr>', desc = 'Workspace Symbols' },
    { '<leader>fd', '<cmd>Telescope diagnostics<cr>', desc = 'Diagnostics' },

    -- Git pickers
    { '<leader>gc', '<cmd>Telescope git_commits<cr>', desc = 'Git Commits' },
    { '<leader>gs', '<cmd>Telescope git_status<cr>', desc = 'Git Status' },

    -- Other useful pickers
    { '<leader>fc', '<cmd>Telescope colorscheme<cr>', desc = 'Colorscheme' },
    { '<leader>fk', '<cmd>Telescope keymaps<cr>', desc = 'Keymaps' },
    { '<leader>fm', '<cmd>Telescope marks<cr>', desc = 'Marks' },
    { '<leader>f/', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Search in Buffer' },
  },

  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup({
      defaults = {
        -- Visual configuration
        prompt_prefix = '🔍 ',
        selection_caret = '➜ ',
        path_display = { 'truncate' }, -- truncate, smart, absolute

        -- File previewer
        file_ignore_patterns = {
          'node_modules',
          '.git/',
          'dist/',
          'build/',
          'target/',
          '%.lock',
        },

        -- Layout configuration
        layout_strategy = 'horizontal', -- horizontal, vertical, center, flex
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },

        -- Sorting strategy
        sorting_strategy = 'ascending', -- ascending or descending

        -- Key mappings inside Telescope
        mappings = {
          i = { -- Insert mode
            ['<C-n>'] = actions.move_selection_next,
            ['<C-p>'] = actions.move_selection_previous,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,

            ['<C-c>'] = actions.close,
            ['<Esc>'] = actions.close,

            ['<Down>'] = actions.move_selection_next,
            ['<Up>'] = actions.move_selection_previous,

            ['<CR>'] = actions.select_default,
            ['<C-x>'] = actions.select_horizontal,
            ['<C-v>'] = actions.select_vertical,
            ['<C-t>'] = actions.select_tab,

            ['<C-u>'] = actions.preview_scrolling_up,
            ['<C-d>'] = actions.preview_scrolling_down,

            -- Send to quickfix list
            ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
            ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,

            -- Cycle through history
            ['<C-Down>'] = actions.cycle_history_next,
            ['<C-Up>'] = actions.cycle_history_prev,

            -- Show available mappings
            ['<C-/>'] = actions.which_key,
          },

          n = { -- Normal mode
            ['q'] = actions.close,
            ['<Esc>'] = actions.close,

            ['<CR>'] = actions.select_default,
            ['<C-x>'] = actions.select_horizontal,
            ['<C-v>'] = actions.select_vertical,
            ['<C-t>'] = actions.select_tab,

            ['j'] = actions.move_selection_next,
            ['k'] = actions.move_selection_previous,
            ['H'] = actions.move_to_top,
            ['M'] = actions.move_to_middle,
            ['L'] = actions.move_to_bottom,

            ['<Down>'] = actions.move_selection_next,
            ['<Up>'] = actions.move_selection_previous,
            ['gg'] = actions.move_to_top,
            ['G'] = actions.move_to_bottom,

            ['<C-u>'] = actions.preview_scrolling_up,
            ['<C-d>'] = actions.preview_scrolling_down,

            ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
            ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,

            ['?'] = actions.which_key,
          },
        },
      },

      -- Picker-specific configurations
      pickers = {
        find_files = {
          theme = 'dropdown',
          previewer = false,
          hidden = true, -- Show hidden files (change to true if needed)
        },
        git_files = {
          theme = 'dropdown',
          previewer = false,
        },
        buffers = {
          theme = 'dropdown',
          previewer = false,
          initial_mode = 'normal',
          mappings = {
            i = {
              ['<C-d>'] = actions.delete_buffer,
            },
            n = {
              ['dd'] = actions.delete_buffer,
            },
          },
        },
        colorscheme = {
          enable_preview = true,
        },
        lsp_references = {
          theme = 'cursor',
          initial_mode = 'normal',
        },
        lsp_definitions = {
          theme = 'cursor',
          initial_mode = 'normal',
        },
        lsp_implementations = {
          theme = 'cursor',
          initial_mode = 'normal',
        },
      },

      -- Extension configurations
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
        },
      },
    })

    -- Load extensions
    telescope.load_extension('fzf')
  end,
}
