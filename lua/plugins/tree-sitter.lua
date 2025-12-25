return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false, -- IMPORTANT: Do NOT lazy-load treesitter
  build = ':TSUpdate',

  config = function()
    -- Install language parsers
    -- This will install them if they're not already installed
    require('nvim-treesitter').install({
      -- Add languages you use
      'lua',
      'python',
      'javascript',
      'typescript',
      'rust',
      'go',
      'html',
      'css',
      'json',
      'yaml',
      'markdown',
      'markdown_inline',
      'bash',
      'vim',
      'vimdoc',
      'regex',
    })

    -- Enable syntax highlighting for specific filetypes
    -- This replaces the old 'highlight.enable' option
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'lua',
        'python',
        'javascript',
        'typescript',
        'rust',
        'go',
        'html',
        'css',
        'json',
        'yaml',
        'markdown',
        'bash',
        'vim',
        'c',
        'cpp',
        'java',
        'ruby',
        'php',
      },
      callback = function()
        vim.treesitter.start()
      end,
    })

    -- Enable treesitter-based folding (optional)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'lua',
        'python',
        'javascript',
        'typescript',
        'rust',
        'go',
        'html',
        'css',
        'json',
        'yaml',
        'markdown',
      },
      callback = function()
        vim.wo[0][0].foldmethod = 'expr'
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldenable = false -- Don't fold by default
        vim.wo[0][0].foldlevel = 99
      end,
    })

    -- Enable treesitter-based indentation (experimental, optional)
    -- Uncomment if you want to try it
    -- vim.api.nvim_create_autocmd('FileType', {
    --   pattern = { 'lua', 'python', 'javascript' },
    --   callback = function()
    --     vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    --   end,
    -- })
  end,
}
