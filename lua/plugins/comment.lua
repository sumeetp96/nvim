return {
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },

    config = function()
      require('Comment').setup({
        -- Add comment string for languages (most are auto-detected)
        padding = true, -- Add space between comment and text
        sticky = true, -- Cursor stays at position
        ignore = nil, -- Ignore empty lines

        -- LHS of toggle mappings in NORMAL mode
        toggler = {
          line = 'gcc', -- Line-comment toggle
          block = 'gbc', -- Block-comment toggle
        },

        -- LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
          line = 'gc', -- Line-comment operator
          block = 'gb', -- Block-comment operator
        },

        -- LHS of extra mappings
        extra = {
          above = 'gcO', -- Add comment on line above
          below = 'gco', -- Add comment on line below
          eol = 'gcA', -- Add comment at end of line
        },

        -- Enable pre-hook for integration with other plugins
        pre_hook = nil,
        post_hook = nil,
      })
    end,
  },
}
