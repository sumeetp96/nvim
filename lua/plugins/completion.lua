return {
  -- LuaSnip: Snippet engine
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
    dependencies = {
      'rafamadriz/friendly-snippets', -- Collection of snippets
    },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load() -- Load friendly-snippets
    end,
  },

  -- nvim-cmp: Completion engine
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter', -- Load on entering insert mode
    dependencies = {
      'hrsh7th/cmp-nvim-lsp', -- LSP completion source
      'hrsh7th/cmp-buffer', -- Buffer words completion
      'hrsh7th/cmp-path', -- File path completion
      'hrsh7th/cmp-cmdline', -- Command line completion
      'saadparwaiz1/cmp_luasnip', -- Snippet completion
      'L3MON4D3/LuaSnip',
      'onsails/lspkind.nvim', -- VS Code-like pictograms
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')

      -- Helper function for super-tab like behavior
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s')
            == nil
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- Window appearance
        window = {
          -- completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        -- Formatting with lspkind for VS Code-like icons
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
            show_labelDetails = true,
          }),
        },

        -- Key mappings
        mapping = cmp.mapping.preset.insert({
          -- Navigate through completion menu
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll documentation window
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Trigger completion menu
          ['<C-Space>'] = cmp.mapping.complete(),

          -- Close completion menu
          ['<C-e>'] = cmp.mapping.abort(),

          -- Confirm selection
          ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Only confirm explicitly selected items

          -- Super Tab-like behavior
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),

        -- Completion sources (order matters - higher priority first)
        sources = cmp.config.sources({
          { name = 'nvim_lsp', priority = 1000 },
          { name = 'luasnip', priority = 750 },
          { name = 'buffer', priority = 500 },
          { name = 'path', priority = 250 },
        }),

        -- Experimental features
        experimental = {
          ghost_text = true, -- Show preview of completion
        },
      })

      -- Command-line completion for search (/ and ?)
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })

      -- Command-line completion for commands (:)
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })
    end,
  },

  -- LSP kind icons
  {
    'onsails/lspkind.nvim',
    lazy = true,
  },

  -- Friendly snippets collection
  {
    'rafamadriz/friendly-snippets',
    lazy = true,
  },
}
