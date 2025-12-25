return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },

  config = function()
    local lint = require('lint')

    -- Configure linters for each filetype
    lint.linters_by_ft = {
      -- JavaScript/TypeScript
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      vue = { 'eslint_d' },
      svelte = { 'eslint_d' },

      -- Python
      python = { 'ruff' }, -- or "pylint" if you prefer

      -- Go
      go = { 'golangcilint' },

      -- Shell
      bash = { 'shellcheck' },
      sh = { 'shellcheck' },

      -- Markdown
      markdown = { 'markdownlint' },

      -- Docker
      dockerfile = { 'hadolint' },

      -- YAML
      yaml = { 'yamllint' },

      -- JSON
      json = { 'jsonlint' },

      -- Add more as needed
    }

    -- Create autocommand to run linting
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        -- Only lint if linter is available
        lint.try_lint()
      end,
    })

    -- Manual linting keymap
    vim.keymap.set('n', '<leader>ll', function()
      lint.try_lint()
    end, { desc = 'Trigger linting for current file' })

    -- Keymap to show linting info
    vim.keymap.set('n', '<leader>li', function()
      local linters = lint.linters_by_ft[vim.bo.filetype]
      if linters then
        print('Linters for ' .. vim.bo.filetype .. ': ' .. table.concat(linters, ', '))
      else
        print('No linters configured for ' .. vim.bo.filetype)
      end
    end, { desc = 'Show configured linters for current filetype' })
  end,
}
