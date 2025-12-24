vim.api.nvim_create_autocmd('BufReadPre', {
  callback = function(args)
    local ok, stats = pcall(vim.loop.fs_stat, args.file)
    if ok and stats and stats.size > 500 * 1024 then
      vim.bo[args.buf].syntax = 'off'
      vim.bo[args.buf].swapfile = false
      vim.bo[args.buf].undofile = false
    end
  end,
})
