local transparent = false

return {
  {
    enabled = true,
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_transparent_background = transparent
      vim.g.everforest_background = 'hard'
      vim.g.everforest_enable_italic = true
      vim.cmd.colorscheme('everforest')
    end,
  },

  {
    enabled = false,
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup({
        variant = 'moon',
        styles = {
          transparency = transparent,
        },
      })
      vim.cmd('colorscheme rose-pine')
    end,
  },

  {
    enabled = false,
    'shaunsingh/nord.nvim',
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      vim.g.nord_disable_background = transparent
      vim.g.nord_italic = false
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_bold = false
      vim.cmd.colorscheme('nord')
    end,
  },
}
