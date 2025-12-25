return {
  -- Mason: Package manager for LSP servers, DAP servers, linters, and formatters
  {
    'mason-org/mason.nvim',
    keys = {
      { '<leader>om', '<cmd>Mason<cr>', desc = 'Mason' },
    },
    opts = {
      ensure_installed = {
        -- Formatters
        'stylua', -- Lua formatter
        'prettier', -- JS/TS/CSS/HTML/JSON formatter
        'black', -- Python formatter
        'isort', -- Python import sorter
        'shfmt', -- Shell formatter
        'clang-format', -- C/C++ formatter
        'taplo', -- TOML formatter

        -- Linters
        'eslint_d', -- JS/TS linter (faster than eslint)
        'ruff', -- Python linter & formatter
        'shellcheck', -- Shell script linter
        'markdownlint', -- Markdown linter
        'hadolint', -- Dockerfile linter
        'yamllint', -- YAML linter
        'jsonlint', -- JSON linter
      },
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      mr:on('package:install:success', function()
        vim.defer_fn(function()
          -- Trigger FileType event to possibly load newly installed tools
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

  -- Mason-LSPConfig: Bridge between Mason and nvim-lspconfig
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {
      -- Automatically install these language servers
      ensure_installed = {
        'lua_ls', -- Lua
        'pyright', -- Python
        'ts_ls', -- TypeScript/JavaScript
        'rust_analyzer', -- Rust
        'gopls', -- Go
        'clangd', -- C/C++
        'html', -- HTML
        'cssls', -- CSS
        'tailwindcss', -- Tailwind CSS
        'jsonls', -- JSON
        'yamlls', -- YAML
        'marksman', -- Markdown
        'bashls', -- Bash
      },

      -- Automatically enable installed servers (default: true)
      -- Set to false if you want to manually configure each server
      automatic_enable = true,

      -- If you want to exclude certain servers from auto-enabling:
      -- automatic_enable = {
      --   exclude = { "rust_analyzer" }
      -- },
    },
  },

  -- LSPConfig: Configurations for Neovim's built-in LSP client
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason-org/mason-lspconfig.nvim',
    },
    config = function()
      -- Setup keymaps and autocommands for LSP
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(event)
          local opts = { buffer = event.buf }

          -- Key mappings for LSP features
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format({ async = true })
          end, opts)

          -- Diagnostic keymaps
          vim.keymap.set('n', '[d', function()
            vim.diagnostic.jump({ count = 1, float = true })
          end, opts)
          vim.keymap.set('n', ']d', function()
            vim.diagnostic.jump({ count = -1, float = true })
          end, opts)
          vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
          vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
        end,
      })

      -- Configure diagnostic display
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

      -- These override the default settings provided by mason-lspconfig
      -- Lua Language Server
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { 'vim' }, -- Recognize 'vim' as a global
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- Python (Pyright)
      vim.lsp.config('pyright', {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = 'basic',
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      -- TypeScript/JavaScript
      local ts_ls_inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
      vim.lsp.config('ts_ls', {
        settings = {
          typescript = {
            inlayHints = ts_ls_inlayHints,
          },
          javascript = {
            inlayHints = ts_ls_inlayHints,
          },
        },
      })

      -- Configure all servers with common settings
      vim.lsp.config('*', {
        capabilities = {
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = true,
              },
            },
          },
        },
      })

      -- Configure all servers with nvim-cmp capabilities
      -- This tells LSP servers what completion features nvim-cmp supports
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      vim.lsp.config('*', {
        capabilities = capabilities,
      })
    end,
  },
}
