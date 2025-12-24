return {
  { 'neovim/nvim-lspconfig' },
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'tsserver', 'lua_ls' },
        automatic_enable = true,
      })
    end,
  },
}
