return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',

  config = function()
    -- Install parsers you need
    require('nvim-treesitter').install({
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

    -- Enable highlighting for filetypes
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
      },
      callback = function()
        vim.treesitter.start()
      end,
    })

    -- Optional: Enable folding
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'lua', 'python', 'javascript', 'typescript', 'rust', 'go' },
      callback = function()
        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldenable = false
        vim.wo.foldlevel = 99
      end,
    })
  end,
}
