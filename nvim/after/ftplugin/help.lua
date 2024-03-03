-- Settings
vim.opt.spell = true

-- Keymaps
local keymap = vim.keymap
local opts = { buffer = true, silent = true }

-- Better tag navigation for german layout
opts.desc = 'Go to help tag (definition)'
keymap.set('n', 'gd', '<C-]>', opts)
