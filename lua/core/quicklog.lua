local M = {}

-- Per-language log templates
local templates = {
  javascript = "console.log(%s);",
  typescript = "console.log(%s);",
  lua = "print(%s)",
  python = "print(%s)",
  go = "fmt.Println(%s)",
  rust = "println!(%s);",
}

local function get_template()
  return templates[vim.bo.filetype] or "%s"
end

-- Get word or visual selection
local function get_expression()
  if vim.fn.mode() == "v" then
    vim.cmd("normal! `<v`>y")
    return vim.fn.getreg('"')
  end
  return vim.fn.expand("<cword>")
end

-- Get context (function name if available)
local function get_context()
  local ok, ts_utils = pcall(require, "nvim-treesitter.ts_utils")
  if not ok then
    return ""
  end

  local node = ts_utils.get_node_at_cursor()
  while node do
    local t = node:type()
    if t == "function_declaration"
      or t == "method_definition"
      or t == "function_definition"
      or t == "arrow_function"
    then
      local name = vim.treesitter.get_node_text(node:child(1), 0)
      return name or ""
    end
    node = node:parent()
  end

  return ""
end

-- Insert log and keep cursor on log line
local function insert_log_line(line)
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row, row, false, { line })
  vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
end

-- Simple log
function M.log_simple()
  local expr = get_expression()
  if expr == "" then return end

  local tpl = get_template()
  local content = string.format("'%s', %s", expr, expr)
  insert_log_line(tpl:format(content))
end

-- Contextual log
function M.log_context()
  local expr = get_expression()
  if expr == "" then return end

  local file = vim.fn.expand("%:t")
  local line = vim.fn.line(".") + 1
  local ctx = get_context()

  local prefix = string.format("[%s:%d]", file, line)
  if ctx ~= "" then
    prefix = prefix .. "[" .. ctx .. "]"
  end

  local tpl = get_template()
  local content = string.format("'%s', '%s', %s", prefix, expr, expr)
  insert_log_line(tpl:format(content))
end

return M
