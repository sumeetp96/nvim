return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPre',

  config = function()
    require('colorizer').setup({
      filetypes = {
        '*',
        css = { css = true, css_fn = true },
        scss = { css = true, css_fn = true },
        html = { names = true },
        javascript = { tailwind = true },
        typescript = { tailwind = true },
        javascriptreact = { tailwind = true },
        typescriptreact = { tailwind = true },
      },

      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = true,
        mode = 'background',
      },
    })

    vim.keymap.set('n', '<leader>ct', '<cmd>ColorizerToggle<cr>', { desc = 'Toggle colorizer' })
  end,
}
