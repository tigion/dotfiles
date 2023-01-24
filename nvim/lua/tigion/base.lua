vim.cmd("autocmd!")

-- encoding
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- title
vim.opt.titlestring = [[%{v:progname} ┊ %t]]

-- shell
vim.opt.shell = 'zsh'

-- disable netrw (for nvim-tree, telescope-file-browser)
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1

-- colors
vim.opt.termguicolors = true

-- line numbers, wrap
vim.opt.relativenumber = false -- toggle with <F8>
vim.wo.number = true -- toggle with <F9>
vim.opt.wrap = false -- no wrap lines

-- indent
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.expandtab = true

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search

-- backup, undo, swap
vim.opt.backup = false
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.swapfile = false

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = '*',
  command = "set nopaste"
})

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }

-- spell checking
vim.opt.spell = false -- toggle with <F10>
vim.opt.spelllang = { 'de', 'en' }

-- [[ Basic Keymaps ]]
-- set leader key
-- Set <space> as the leader key
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--
vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.cmdheight = 1
vim.opt.inccommand = 'split'
vim.opt.laststatus = 2
vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
vim.opt.scrolloff = 10
vim.opt.showcmd = true
vim.opt.title = true
vim.opt.updatetime = 50
vim.opt.wildignore:append { '*/node_modules/*' }
--vim.opt.colorcolumn = "80"
vim.opt.fillchars:append('eob: ') -- no ~ on not existent lines
