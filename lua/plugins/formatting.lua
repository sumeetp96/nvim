return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' }, -- Lazy load on opening files

  config = function()
    local conform = require('conform')

    conform.setup({
      -- Define formatters for each filetype
      formatters_by_ft = {
        -- Web Development
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        vue = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        less = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        jsonc = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        graphql = { 'prettier' },
        handlebars = { 'prettier' },

        -- Lua
        lua = { 'stylua' },

        -- Python
        python = { 'isort', 'black' },

        -- Go
        go = { 'goimports', 'gofmt' },

        -- Rust (rustfmt is usually run by rust-analyzer LSP)
        rust = { 'rustfmt' },

        -- Shell
        bash = { 'shfmt' },
        sh = { 'shfmt' },

        -- C/C++
        c = { 'clang_format' },
        cpp = { 'clang_format' },

        -- Other
        toml = { 'taplo' },

        -- You can use a function to determine formatters dynamically
        -- ["*"] = { "trim_whitespace" }, -- For all files
      },

      -- Format on save configuration
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = 'fallback', -- Use LSP formatting if no formatter is available
      },

      -- You can also format on save asynchronously (doesn't block)
      -- Uncomment this and comment out format_on_save above if you prefer
      -- format_on_save = function(bufnr)
      --   -- Disable with a global or buffer-local variable
      --   if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      --     return
      --   end
      --   return {
      --     timeout_ms = 500,
      --     lsp_format = "fallback",
      --   }
      -- end,

      -- Customize formatters
      formatters = {
        shfmt = {
          prepend_args = { '-i', '2' }, -- Use 2 spaces for indentation
        },
        -- You can add more formatter customizations here
      },
    })

    -- Manual format keymap
    vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
      conform.format({
        lsp_format = 'fallback',
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = 'Format file or range (in visual mode)' })

    -- Command to toggle format on save
    vim.api.nvim_create_user_command('FormatToggle', function(args)
      if args.bang then
        -- FormatToggle! will toggle for current buffer
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        print('Buffer format on save: ' .. (vim.b.disable_autoformat and 'disabled' or 'enabled'))
      else
        -- FormatToggle will toggle globally
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        print('Global format on save: ' .. (vim.g.disable_autoformat and 'disabled' or 'enabled'))
      end
    end, {
      desc = 'Toggle autoformat on save',
      bang = true,
    })
  end,
}
