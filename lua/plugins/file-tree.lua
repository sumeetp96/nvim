return {
  'nvim-tree/nvim-tree.lua',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  keys = {
    { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle file tree' },
    { '<leader>o', '<cmd>NvimTreeFocus<cr>', desc = 'Focus file tree' },
    { '<leader>nf', '<cmd>NvimTreeFindFile<cr>', desc = 'Find current file in tree' },
    { '<leader>nc', '<cmd>NvimTreeCollapse<cr>', desc = 'Collapse file tree' },
  },

  init = function()
    -- Disable netrw
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,

  config = function()
    local nvim_tree = require('nvim-tree')

    nvim_tree.setup({
      update_focused_file = {
        enable = true,
      },
      view = {
        width = 35,
        side = 'right',
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          show = {
            git = true,
            modified = true,
          },
        },
      },
      actions = {
        change_dir = {
          restrict_above_cwd = true,
        },
        open_file = {
          window_picker = {
            enable = true,
          },
        },
      },
      filters = {
        dotfiles = true,
        custom = { '^.git$', '^node_modules$', '^.cache$' },
      },
      git = {
        ignore = false,
      },
      trash = {
        cmd = 'trash',
      },
    })

    -- Auto close when last window
    vim.api.nvim_create_autocmd('QuitPre', {
      callback = function()
        local tree_wins = {}
        local floating_wins = {}
        local wins = vim.api.nvim_list_wins()
        for _, w in ipairs(wins) do
          local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
          if bufname:match('NvimTree_') ~= nil then
            table.insert(tree_wins, w)
          end
          if vim.api.nvim_win_get_config(w).relative ~= '' then
            table.insert(floating_wins, w)
          end
        end
        if #wins - #floating_wins - #tree_wins == 1 then
          for _, w in ipairs(tree_wins) do
            vim.api.nvim_win_close(w, true)
          end
        end
      end,
    })
  end,
}
