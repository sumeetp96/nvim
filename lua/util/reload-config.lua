local M = {}

function M.reload()
  for name, _ in pairs(package.loaded) do
    if name:match('^config') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)

  vim.notify('Neovim config reloaded', vim.log.levels.INFO)
end

return M
