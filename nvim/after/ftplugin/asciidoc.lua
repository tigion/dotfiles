-- Settings
vim.opt.spell = true

-- Keymaps
local keymap = vim.keymap
local opts = { buffer = true, silent = true }

-- Find AsciiDoc headers (from level 2)
-- - No recognition of code blocks
opts.desc = 'Find headers'
keymap.set('n', '<Leader>Ah', [[/^==\+ .\+<CR>]], opts)
opts.desc = 'Find headers to location list'
keymap.set('n', '<Leader>AH', [[:lvimgrep /^==\+ .\+/ %<CR>]], opts)
