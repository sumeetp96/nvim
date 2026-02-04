return {
  enabled = false,
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = 'VeryLazy',

  keys = {
    { '<leader>bp', '<cmd>BufferLinePick<cr>', desc = 'Pick buffer' },
    { '<leader>bP', '<cmd>BufferLinePickClose<cr>', desc = 'Pick buffer to close' },
    { '<leader>bse', '<cmd>BufferLineSortByExtension<cr>', desc = 'Sort by extension' },
    { '<leader>bsd', '<cmd>BufferLineSortByDirectory<cr>', desc = 'Sort by directory' },
    { '<leader>bh', '<cmd>BufferLineCloseLeft<cr>', desc = 'Close all to the left' },
    { '<leader>bl', '<cmd>BufferLineCloseRight<cr>', desc = 'Close all to the right' },
    { '<leader>bo', '<cmd>BufferLineCloseOthers<cr>', desc = 'Close all others' },
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Previous buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
    { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Previous buffer' },
    { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
    { '<leader>b1', '<cmd>BufferLineGoToBuffer 1<cr>', desc = 'Go to buffer 1' },
    { '<leader>b2', '<cmd>BufferLineGoToBuffer 2<cr>', desc = 'Go to buffer 2' },
    { '<leader>b3', '<cmd>BufferLineGoToBuffer 3<cr>', desc = 'Go to buffer 3' },
    { '<leader>b4', '<cmd>BufferLineGoToBuffer 4<cr>', desc = 'Go to buffer 4' },
    { '<leader>b5', '<cmd>BufferLineGoToBuffer 5<cr>', desc = 'Go to buffer 5' },
  },

  config = function()
    require('bufferline').setup({
      options = {
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level)
          local icon = level:match('error') and ' ' or ' '
          return ' ' .. icon .. count
        end,

        offsets = {
          {
            filetype = 'NvimTree',
            text = 'File Explorer',
            text_align = 'center',
            separator = true,
          },
        },

        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' },
        },

        sort_by = 'insert_after_current',
      },
    })
  end,
}
