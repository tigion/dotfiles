local status, n = pcall(require, 'monokai')
if (not status) then return end

n.setup {
  comment_italics = true,
}

-- Set transparent background
--vim.cmd "hi Normal guibg=NONE ctermbg=NONE"
vim.cmd 'hi Normal guibg=NONE'
vim.cmd 'hi NonText guibg=NONE'
--vim.cmd "hi LineNr guibg=NONE guifg=#666666"
vim.cmd 'hi LineNr guibg=NONE guifg=#665544'
