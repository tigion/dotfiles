local status, ibl = pcall(require, 'indent_blankline')
if (not status) then return end

vim.cmd [[highlight IndentBlanklineChar guifg=#303030 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContextChar guifg=#574100 gui=nocombine]]

ibl.setup {
  use_treesitter = true,
  char = '┊',
  context_char = '┊',
  show_current_context = true,
  show_trailing_blankline_indent = false,
}