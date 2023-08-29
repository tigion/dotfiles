return {
  'lukas-reineke/indent-blankline.nvim',        -- highlight indention level
  dependencies = { 'nvim-tree/nvim-tree.lua' }, -- treesitter
  config = function()
    local indentBlankline = require('indent_blankline')

    vim.cmd [[highlight IndentBlanklineChar guifg=#303030 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineContextChar guifg=#574100 gui=nocombine]]

    indentBlankline.setup {
      use_treesitter = true,
      char = '┊',
      context_char = '┊',
      show_current_context = true,
      show_trailing_blankline_indent = false,
    }
  end,
}