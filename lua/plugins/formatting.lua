return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },

  config = function()
    local conform = require('conform')

    conform.setup({
      formatters_by_ft = {
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        vue = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        go = { 'goimports', 'gofmt' },
        rust = { 'rustfmt' },
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        c = { 'clang_format' },
        cpp = { 'clang_format' },
        toml = { 'taplo' },
      },

      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
    })

    -- Manual format keymap
    vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
      conform.format({ lsp_format = 'fallback', timeout_ms = 1000 })
    end, { desc = 'Format file or range' })

    -- Toggle format on save
    vim.api.nvim_create_user_command('FormatToggle', function(args)
      if args.bang then
        vim.b.disable_autoformat = not vim.b.disable_autoformat
      else
        vim.g.disable_autoformat = not vim.g.disable_autoformat
      end
    end, {
      desc = 'Toggle format on save',
      bang = true,
    })
  end,
}
