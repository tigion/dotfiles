local M = {}

-- diagnostics
M.diagnostic = {
  signs = {
    error = '', --  
    warn = '', -- 
    info = '', -- 
    hint = '󱧢', -- 󰌵 󱧢
  },
  virtual_text_prefix = '',
}
-- local diagnostic_signs = {
--   error = '', --  
--   warn = '', -- 
--   info = '', -- 
--   hint = '󱧢', -- 󰌵 󱧢
-- }
-- for k, v in pairs(diagnostic_signs) do
--   -- Adds signs in lowercase and first letter uppercase
--   -- v = v .. ' ' -- add a space after icon
--   M.diagnostic.signs[k:lower()] = v
--   M.diagnostic.signs[k:sub(1, 1):upper() .. k:sub(2, -1):lower()] = v
-- end

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

M.option = {
  spell = '󰓆',
}

-- lsp
M.lsp = {
  server_active = '󱎴',
  server_none = '󰶐',
}

-- tools
M.neovim = ''
M.snacks = '󱥰'
M.telescope = ''
M.codeium = '󰘦'
M.copilot = {
  enabled = '',
  disabled = '',
  warning = '',
  nes = {
    has = '󰭺',
    process = '󱋊',
  },
}
M.supermaven = '󱙺'
M.supermaven_error = '󱙻'

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
  Copilot = M.copilot.enabled,
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
  Snippet = '󱄽', -- ,
  Supermaven = M.supermaven,
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
