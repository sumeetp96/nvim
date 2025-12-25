return {
  'nvim-tree/nvim-tree.lua',
  lazy = false, -- Load immediately (lazy loading not recommended)
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- File icons
  },

  keys = {
    { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle file tree' },
    { '<leader>o', '<cmd>NvimTreeFocus<cr>', desc = 'Focus file tree' },
    { '<leader>nf', '<cmd>NvimTreeFindFile<cr>', desc = 'Find current file in tree' },
    { '<leader>nc', '<cmd>NvimTreeCollapse<cr>', desc = 'Collapse file tree' },
  },

  init = function()
    -- Disable netrw (Vim's built-in file explorer)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Enable 24-bit color
    vim.opt.termguicolors = true
  end,

  config = function()
    local nvim_tree = require('nvim-tree')

    nvim_tree.setup({
      -- Disable opening at startup
      disable_netrw = true,
      hijack_netrw = true,

      -- Update the focused file on `BufEnter` and show it in the tree
      update_focused_file = {
        enable = true,
        update_root = false, -- Don't change root directory
        ignore_list = {},
      },

      -- View settings
      view = {
        width = 35,
        side = 'right',
        number = false,
        relativenumber = false,
        signcolumn = 'yes',
      },

      -- Renderer settings
      renderer = {
        root_folder_label = ':~:s?$?/..?', -- Show relative path
        indent_width = 2,
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = '└',
            edge = '│',
            item = '│',
            bottom = '─',
            none = ' ',
          },
        },
        icons = {
          web_devicons = {
            file = {
              enable = true,
              color = true,
            },
            folder = {
              enable = false,
              color = true,
            },
          },
          git_placement = 'before',
          modified_placement = 'after',
          padding = ' ',
          symlink_arrow = ' ➛ ',
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
          },
          glyphs = {
            default = '󰈚',
            symlink = '',
            bookmark = '󰆤',
            modified = '●',
            folder = {
              arrow_closed = '',
              arrow_open = '',
              default = '󰉋',
              open = '󰝰',
              empty = '󰉖',
              empty_open = '󰷏',
              symlink = '󰉒',
              symlink_open = '󰷏',
            },
            git = {
              unstaged = '✗',
              staged = '✓',
              unmerged = '',
              renamed = '➜',
              untracked = '★',
              deleted = '',
              ignored = '◌',
            },
          },
        },
        special_files = { 'Cargo.toml', 'Makefile', 'README.md', 'readme.md' },
        symlink_destination = true,
      },

      -- Hijack cursor in tree to show cursor line
      hijack_cursor = true,

      -- Auto reload on tree changes
      reload_on_bufenter = false,
      respect_buf_cwd = false,

      -- Actions
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        open_file = {
          quit_on_open = false,
          resize_window = true,
          window_picker = {
            enable = true,
            picker = 'default',
            chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
            exclude = {
              filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
              buftype = { 'nofile', 'terminal', 'help' },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },

      -- Filters
      filters = {
        dotfiles = true, -- Show hidden files
        git_clean = false,
        no_buffer = false,
        custom = { '^.git$', '^node_modules$', '^.cache$' }, -- Hide these
        exclude = {}, -- Always show these files
      },

      -- Git integration
      git = {
        enable = true,
        ignore = false, -- Show ignored files
        show_on_dirs = true,
        show_on_open_dirs = true,
        timeout = 400,
      },

      -- Modified files
      modified = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
      },

      -- Filesystem watchers
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {},
      },

      -- Trash settings (for deletion)
      trash = {
        cmd = 'trash', -- or "gio trash" on Linux
      },

      -- Log settings
      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          dev = false,
          diagnostics = false,
          git = false,
          profile = false,
          watcher = false,
        },
      },
    })

    -- Auto-close nvim-tree when it's the last window
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
          -- Should quit, so we close all invalid windows
          for _, w in ipairs(tree_wins) do
            vim.api.nvim_win_close(w, true)
          end
        end
      end,
    })
  end,
}
