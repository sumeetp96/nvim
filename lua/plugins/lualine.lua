return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',

    config = function()
      require('lualine').setup({
        options = {
          theme = 'auto',
          globalstatus = true,
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = {
            {
              function()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if next(clients) == nil then
                  return ''
                end
                local names = {}
                for _, client in pairs(clients) do
                  table.insert(names, client.name)
                end
                return ' ' .. table.concat(names, ', ')
              end,
            },
            'encoding',
            'fileformat',
            'filetype',
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        extensions = { 'nvim-tree', 'lazy', 'mason' },
      })
    end,
  },
}
