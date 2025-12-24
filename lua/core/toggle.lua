local M = {}

local toggles = {
  ["true"] = "false",
  ["false"] = "true",
  ["True"] = "False",
  ["False"] = "True",
  ["yes"] = "no",
  ["no"] = "yes",
  ["on"] = "off",
  ["off"] = "on",
  ["0"] = "1",
  ["1"] = "0",
}

function M.toggle_bool()
  local word = vim.fn.expand("<cword>")
  local replacement = toggles[word]
  if not replacement then
    return
  end

  -- Save cursor position
  local cursor = vim.api.nvim_win_get_cursor(0)

  -- Replace word under cursor without yanking
  vim.cmd(("silent! s/\\<%s\\>/%s/"):format(word, replacement))

  -- Restore cursor
  vim.api.nvim_win_set_cursor(0, cursor)
end

return M
