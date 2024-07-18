-- Options

local opt = vim.opt
local api = vim.api

-- OS specific
local isMac = vim.fn.has('macunix')
local isWin = vim.fn.has('win32')

-- reset all autocommands
-- vim.cmd('autocmd!')

-- Encoding
vim.scriptencoding = 'utf-8'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

-- Title
opt.title = true
opt.titlestring = [[%{v:progname} ┊ %t]]

-- Shell
opt.shell = 'zsh'

-- Colors / Transparency
opt.termguicolors = true
opt.background = 'dark'
opt.pumblend = 0
opt.winblend = 10

-- Highlight current line
opt.cursorline = true

-- Highlight when yanking (copying) text (on `yy` or `yap` for example)
api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = api.nvim_create_augroup('highlight_yank', { clear = true }),
  callback = function() vim.highlight.on_yank({ higroup = 'Visual' }) end,
})

-- Line numbers
opt.relativenumber = false -- toggle with <F8>
opt.number = true -- toggle with <F9>
opt.signcolumn = 'yes'

-- Line wrapping
opt.wrap = false -- disable line wrapping (toggle with <F7>)
opt.linebreak = true -- If wrapping, don't break in the middle of words
opt.smoothscroll = true -- If wrapping, use smooth scrolling

-- Indent
opt.smarttab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true
opt.expandtab = true

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true -- Case insensitive searching unless `/C`
opt.smartcase = true -- Case sensitive searching if mixed cases in search
opt.inccommand = 'split' -- Live substitution

-- Backup, undo, swap
opt.backup = false
opt.backupskip = { '/tmp/*', '/private/tmp/*' }
opt.undofile = true
opt.swapfile = false

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  command = 'set nopaste',
})

-- Add asterisks in block comments
opt.formatoptions:append({ 'r' })

-- Spell checking
-- - "de": new German spelling
-- - "de_de": old and new German spelling
opt.spell = false -- toggle with <F10>
opt.spelllang = { 'de', 'en_us' }

-- Splitting
opt.splitbelow = true -- open new split below
opt.splitright = true -- open new split right

-- Others
opt.backspace = { 'start', 'eol', 'indent' }
opt.cmdheight = 1
opt.laststatus = 3 -- global statusline (2 local)
opt.path:append({ '**' }) -- Finding files - Search down into subfolders
opt.scrolloff = 10
opt.showcmd = true
opt.updatetime = 50
opt.wildignore:append({ '*/node_modules/*' })
--opt.colorcolumn = "80"
opt.fillchars:append('eob: ') -- no ~ on not existent lines
opt.timeout = true
opt.timeoutlen = 300 -- quickly trigger keymaps (default 1000)

-- Clippboard
if isMac then
  opt.clipboard:append({ 'unnamedplus' })
elseif isWin then
  opt.clipboard:prepend({ 'unnamed', 'unnamedplus' })
end
