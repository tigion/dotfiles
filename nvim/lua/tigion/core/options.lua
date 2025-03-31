-- Options

local opt = vim.opt
local o = vim.o
local api = vim.api

-- NOTE: `vim.opt` vs `vim.o` (`:h lua-guide-options`)
--
-- Set one value:
--   `vim.opt.spell = false`
--   `vim.o.spell = false`
-- Set multiple values:
--   `vim.opt.spelllang = { 'de', 'en_us' }`
--   `vim.o.spelllang = 'de,en_us'`
-- Append (multiple) values:
--   `vim.opt.wildignore:append({ '*/node_modules/*' })`
--   `vim.o.wildignore = vim.o.wildignore .. ',*/node_modules/*'`

-- OS specific
local isMac = vim.fn.has('macunix')
local isWin = vim.fn.has('win32')

-- Keyboard specific
--
-- NOTE: Some special prev/next keymaps for a German keyboard layout.
--       - `ü`, `+` -> `[`, `]`
--       - `Ü`, `Ä` -> `{`, `}` (for `*` the default behaviour is used)
--
-- Exchanges the meaning of the characters `ü+ÜÄ` to `[]{}` in Normal mode.
opt.langmap = 'ü[+]Ü{Ä}'
-- The following remaps are necessary for the special keymaps.
vim.keymap.set('n', 'ü', '[', { remap = true })
vim.keymap.set('n', 'üü', '[[', { remap = true })
vim.keymap.set('n', 'Ü', '{', { remap = true })
vim.keymap.set('n', 'Ä', '}', { remap = true })

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
opt.winblend = 0 -- floating window background transparency

-- Highlight current line
opt.cursorline = true

-- Line numbers
opt.relativenumber = true -- toggle with <F8>
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

-- Add asterisks in block comments
opt.formatoptions:append({ 'r' })

-- Spell checking
-- - "de": new German spelling
-- - "de_de": old and new German spelling
-- - "en": all English regions
-- - "en_us": American English
-- - "en_gb": British English
opt.spell = false -- toggle with <F10>
opt.spelllang = { 'de', 'en_us' }

-- Splitting
opt.splitbelow = true -- open new split below
opt.splitright = true -- open new split right

-- Others
opt.backspace = { 'start', 'eol', 'indent' }
opt.cmdheight = 1
--opt.colorcolumn = "80"
opt.fillchars:append('eob: ') -- no ~ on not existent lines
opt.laststatus = 3 -- global statusline (2 local)
opt.path:append({ '**' }) -- Finding files - Search down into subfolders
opt.ruler = false -- hide the ruler
opt.scrolloff = 4
opt.showcmd = true
opt.showmode = false -- hide mode (is in extra statusline)
opt.smoothscroll = true
opt.timeout = true
opt.timeoutlen = 300 -- quickly trigger keymaps (default 1000)
opt.updatetime = 50
opt.wildignore:append({ '*/node_modules/*' })
opt.wildmode = 'longest:full,full'

if vim.fn.has('nvim-0.11') == 1 then
  -- o.winborder = 'rounded' -- default border for all floating windows
  -- opt.winborder = 'rounded' -- default border for all floating windows
end

-- Clippboard
if isMac then
  opt.clipboard:append({ 'unnamedplus' })
elseif isWin then
  opt.clipboard:prepend({ 'unnamed', 'unnamedplus' })
end
