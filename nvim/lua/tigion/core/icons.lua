local M = {}

-- diagnostics
local diagnostics = {
  error = '', --  
  warn = '', -- 
  hint = '󱧢', -- 󰌵 󱧢
  info = '', -- 
}
M.diagnostics = {}
for k, v in pairs(diagnostics) do
  -- v = v .. ' ' -- add a space after icon
  M.diagnostics[k:lower()] = v
  M.diagnostics[k:sub(1, 1):upper() .. k:sub(2, -1):lower()] = v
end

-- folding markers
M.folding = {
  closed = '▸', -- ''
  open = '▾', -- ''
}

-- git
M.git = {
  branch = '',

  unstaged = '', --  󰛿 (modified)
  staged = '', -- 
  -- unmerged  = '',
  renamed = '󰛂', -- 󰛂 󰁖󱖘󰁗
  untracked = '', --  󰐗󰐙 (new)
  deleted = '', --  󰍶󰍷
  ignored = '󰢤', -- 󰢤◌
}

M.git.diff = {
  added = M.git.untracked,
  modified = M.git.unstaged,
  removed = M.git.deleted,
}

-- tools
M.neovim = ''
M.telescope = ''
M.codeium = '󰘦'
M.copilot = ''

-- code symbols
M.code = {
  Array = '',
  Boolean = '󰨙',
  Class = '',
  Codeium = M.codeium,
  Color = '',
  Control = '',
  Collapsed = '',
  Component = '󰅴',
  Constant = '󰏿',
  Constructor = '',
  Copilot = M.copilot,
  Enum = '',
  EnumMember = '',
  Event = '',
  Field = '',
  File = '',
  Folder = '',
  Fragment = '󰅴',
  Function = '󰊕',
  Interface = '',
  Key = '',
  Macro = '',
  Keyword = '',
  Method = '󰊕',
  Module = '',
  Namespace = '󰦮',
  Null = '',
  Number = '󰎠',
  Object = '',
  Operator = '',
  Package = '',
  Parameter = '',
  Property = '',
  Reference = '',
  Snippet = '',
  StaticMethod = '',
  String = '',
  Struct = '󰆼',
  TabNine = '󰏚',
  Text = '',
  TypeAlias = '',
  TypeParameter = '', -- 𝙏
  Unit = '',
  Value = '',
  Variable = '󰀫',
}

return M
