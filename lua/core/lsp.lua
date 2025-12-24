local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'ts_ls', 'lua_ls' },
  automatic_enable = false,
})

-- Keymaps
local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr }
  local map = vim.keymap.set
  map('n', 'gd', vim.lsp.buf.definition, opts)
  map('n', 'K', vim.lsp.buf.hover, opts)
  map('n', 'gr', vim.lsp.buf.references, opts)
  map(
    'n',
    '<leader>rn',
    vim.lsp.buf.rename,
    vim.tbl_deep_extend('force', opts, { desc = 'Rename symbol' })
  )
  map(
    'n',
    '<leader>ca',
    vim.lsp.buf.code_action,
    vim.tbl_deep_extend('force', opts, { desc = 'Code action' })
  )
end

-- Configure options with vim.lsp.config
vim.lsp.config('ts_ls', {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    typescript = {
      tsserver = {
        maxTsServerMemory = 4096,
      },
    },
  },
  root_dir = require('lspconfig.util').root_pattern(
    'tsconfig.json',
    'jsconfig.json',
    'package.json',
    '.git'
  ),
})

vim.lsp.config('lua_ls', {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = { diagnostics = { globals = { 'vim' } } },
  },
})

vim.lsp.enable({ 'ts_ls', 'lua_ls' })
