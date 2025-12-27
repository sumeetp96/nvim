return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',

    config = function()
      local wk = require('which-key')
      wk.setup({
        win = { border = 'rounded' },
      })

      wk.add({
        { '<leader>f', group = 'Find' },
        { '<leader>g', group = 'Git' },
        { '<leader>h', group = 'Hunks' },
        { '<leader>n', group = 'NvimTree' },
        { '<leader>t', group = 'Tab & Toggle' },
        { '<leader>c', group = 'Code' },
        { '<leader>m', group = 'Misc' },
      })
    end,
  },
}
