return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },

  config = function()
    require('gitsigns').setup({
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },

      current_line_blame_opts = {
        delay = 1000,
      },

      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']h', bang = true })
          else
            gitsigns.nav_hunk('next')
          end
        end, 'Next hunk')

        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[h', bang = true })
          else
            gitsigns.nav_hunk('prev')
          end
        end, 'Previous hunk')

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk, 'Stage hunk')
        map('n', '<leader>hr', gitsigns.reset_hunk, 'Reset hunk')
        map('n', '<leader>hS', gitsigns.stage_buffer, 'Stage buffer')
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, 'Undo stage hunk')
        map('n', '<leader>hR', gitsigns.reset_buffer, 'Reset buffer')
        map('n', '<leader>hp', gitsigns.preview_hunk, 'Preview hunk')
        map('n', '<leader>hb', function()
          gitsigns.blame_line({ full = true })
        end, 'Blame line')
        -- Open diff in split
        map('n', '<leader>hd', function()
          vim.cmd('split')
          gitsigns.diffthis()
        end, 'Diff this (vsplit)')

        -- Open diff in new tab
        map('n', '<leader>hD', function()
          vim.cmd('tabnew %')
          gitsigns.diffthis()
        end, 'Diff this (new tab)')
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, 'Toggle git blame')

        -- Visual mode
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, 'Stage hunk')

        map('v', '<leader>hr', function()
          gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, 'Reset hunk')

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Select hunk')
      end,
    })
  end,
}
