-- Settings
vim.opt_local.spell = true

-- Keymaps
local keymap = vim.keymap
local opts = { buffer = true, silent = true }

-- Change code block syntax from Markdown to Asciidoctor
opts.desc = 'Change Markdown to Asciidoctor code blocks'
keymap.set('n', '<Leader>A1', [[:%s/```\(.*\)\(\_.\{-}\)```/[source,\1]\r----\2----/gc<CR>]], opts)

-- Find AsciiDoc headers (from level 2)
-- - No recognition of code blocks
opts.desc = 'Find headers'
keymap.set('n', '<Leader>Ah', [[/^==\+ .\+<CR>]], opts)
opts.desc = 'Find headers to location list'
keymap.set('n', '<Leader>AH', [[:lvimgrep /^==\+ .\+/ %<CR>]], opts)
