local status, ibl = pcall(require, "indent_blankline")
if (not status) then return end

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#303030 gui=nocombine]]

ibl.setup {
  char_highlight_list = {'IndentBlanklineIndent1'},
  char = '┊',
  --show_current_context = true,
  show_trailing_blankline_indent = false,
}

