local M = {}

local function git_branch()
  local head = vim.b.gitsigns_head
  if head and head ~= "" then
    return " " .. head
  end
  return ""
end

local function diagnostics()
  local counts = {
    error = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }),
    warn  = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }),
  }

  local parts = {}
  if counts.error > 0 then
    table.insert(parts, "E:" .. counts.error)
  end
  if counts.warn > 0 then
    table.insert(parts, "W:" .. counts.warn)
  end

  return table.concat(parts, " ")
end

function M.statusline()
  local filename = "%f"
  local modified = "%m"
  local readonly = "%r"

  local left = table.concat({
    " ",
    filename,
    modified,
    readonly,
    " ",
    git_branch(),
  })

  local right = table.concat({
    diagnostics(),
    " ",
    "%l:%c",
    " ",
  })

  return table.concat({
    left,
    "%=",
    right,
  })
end

return M
