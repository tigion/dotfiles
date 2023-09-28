return {
  'lukas-reineke/indent-blankline.nvim',        -- highlight indention level
  dependencies = { 'nvim-tree/nvim-tree.lua' }, -- treesitter
  main = 'ibl',
  opts = {
    --[[
    Note:
    - scope != current idention level
    - default highlight groups: 'IblIndent', 'IblWhitespace', 'IblScope'
    ]]
    indent = {
      char = '┊',
      -- highlight = 'IblIndent', -- configured in theme.lua
    },
    -- whitespace = {},
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
      -- highlight = 'IblScope', -- configured in theme.lua
      priority = 500,
    },
  },
  -- config = function()
  --   vim.cmd [[highlight IndentBlanklineChar guifg=#303030 gui=nocombine]]
  --   vim.cmd [[highlight IndentBlanklineContextChar guifg=#574100 gui=nocombine]]
  --
  --   require('ibl').setup {
  --     -- v3
  --     indent = {
  --       char = '┊',
  --       -- highlight = 'IndentBlanklineChar',
  --     },
  --     -- whitespace = { },
  --     scope = {
  --       enabled = true,
  --       show_start = false,
  --       show_end = false,
  --       -- injected_languages = false,
  --       highlight = 'IblContext',
  --       priority = 500,
  --     },
  --
  --     -- v2
  --     -- use_treesitter = true,
  --     -- char = '┊',
  --     -- context_char = '┊',
  --     -- show_current_context = true,
  --     -- show_trailing_blankline_indent = false,
  --   }
  -- end,
}