vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat (use ! for buffer)',
  bang = true,
})

vim.api.nvim_create_user_command('FormatEnable', function()
  vim.g.disable_autoformat = false
  vim.b.disable_autoformat = false
end, {
  desc = 'Enable autoformat',
})
