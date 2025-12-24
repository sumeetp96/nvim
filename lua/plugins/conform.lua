return {
  {
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          lua = { 'stylua' },
          javascript = { 'prettier' },
          typescript = { 'prettier' },
          javascriptreact = { 'prettier' },
          typescriptreact = { 'prettier' },
          json = { 'prettier' },
          html = { 'prettier' },
          css = { 'prettier' },
          markdown = { 'prettier' },
        },
        format_on_save = function(bufnr)
          -- allow disabling globally or per buffer
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          return {
            timeout_ms = 1000,
            lsp_fallback = false,
          }
        end,
      })

      vim.keymap.set('n', '<leader>f', function()
        require('conform').format({ async = true })
      end)
    end,
  },
}
