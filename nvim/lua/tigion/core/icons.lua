local M = {}

-- diagnostics
local diagnostics = {
  error = ' ', --  
  warn = ' ', -- 
  hint = ' ', -- 󰌵 
  info = ' ', -- 
}
M.diagnostics = {
  Error = diagnostics.error,
  error = diagnostics.error,
  Warn = diagnostics.warn,
  warn = diagnostics.warn,
  Hint = diagnostics.hint,
  hint = diagnostics.hint,
  Info = diagnostics.info,
  info = diagnostics.info,
}
-- function M.x()
--   local tmp = {}
--   for k, v in pairs(M.diagnostics) do
--     tmp[k:lower()] = v
--   end
--   return tmp
-- end

-- folder
M.folder = {
  arrow_closed = '▸',
  arrow_open = '▾',
}

-- git
M.git = {
  unstaged = '', -- ✗ (modified)
  staged = '', -- ✓
  -- unmerged  = '',
  renamed = '󰛂', -- ➜
  untracked = '', -- ★ (new)
  deleted = '', -- 
  ignored = '󰢤', -- ◌
}

M.telescope = ''
M.codeium = '󰘦'

return M
