return {
  -- Package manager for LSP/formatters/linters
  {
    'mason-org/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    opts = {
      ensure_installed = {
        -- Formatters
        'stylua',
        'prettier',
        'black',
        'isort',
        'shfmt',
        'clang-format',
        'rustfmt',
        -- 'gofmt',
        'goimports',
        'taplo',

        -- Linters
        'eslint_d',
        'ruff',
        'golangci-lint',
        'shellcheck',
        'markdownlint',
        'hadolint',
        'yamllint',
        'jsonlint',
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      mr:on('package:install:success', function()
        vim.defer_fn(function()
          require('lazy.core.handler.event').trigger({
            event = 'FileType',
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  -- Bridge between Mason and LSP
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = { 'mason-org/mason.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      ensure_installed = {
        'lua_ls',
        'pyright',
        'ts_ls',
        'rust_analyzer',
        'gopls',
        'clangd',
        'html',
        'cssls',
        'tailwindcss',
        'jsonls',
        'yamlls',
        'marksman',
        'bashls',
      },
    },
  },

  -- Configure LSP servers
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'mason-org/mason-lspconfig.nvim' },
    config = function()
      -- Keymaps on LSP attach
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
          end

          map('gd', vim.lsp.buf.definition, 'Go to definition')
          map('gD', vim.lsp.buf.declaration, 'Go to declaration')
          map('gr', vim.lsp.buf.references, 'Show references')
          map('gi', vim.lsp.buf.implementation, 'Go to implementation')
          map('K', vim.lsp.buf.hover, 'Hover documentation')
          map('<leader>sh', vim.lsp.buf.signature_help, 'Signature help')
          map('<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
          map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
          map('<leader>f', function()
            vim.lsp.buf.format({ async = true })
          end, 'Format')
          -- Diagnostic keymaps
          map('[d', function()
            vim.diagnostic.jump({ count = 1, float = true })
          end, 'Previous diagnostic')
          map(']d', function()
            vim.diagnostic.jump({ count = -1, float = true })
          end, 'Next diagnostic')
          map('<leader>d', vim.diagnostic.open_float, 'Show diagnostic')
          map('<leader>q', vim.diagnostic.setloclist, 'Diagnostic list')

          -- Organize imports for JS/TS files
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.name == 'ts_ls' then
            map('<leader>co', function()
              vim.lsp.buf.code_action({
                apply = true,
                context = {
                  only = { 'source.organizeImports' },
                  diagnostics = {},
                },
              })
            end, 'Organize imports')
          end
        end,
      })

      -- Diagnostic configuration
      vim.diagnostic.config({
        virtual_text = false,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚',
            [vim.diagnostic.severity.WARN] = '󰀪',
            [vim.diagnostic.severity.INFO] = '󰌶',
            [vim.diagnostic.severity.HINT] = '»',
          },
        },
        float = {
          border = 'rounded',
          source = 'if_many',
        },
      })

      -- Server-specific configurations
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      vim.lsp.config('pyright', {
        settings = {
          python = {
            analysis = { typeCheckingMode = 'basic' },
          },
        },
      })

      -- Integrate with nvim-cmp
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      vim.lsp.config('*', { capabilities = capabilities })
    end,
  },
}
