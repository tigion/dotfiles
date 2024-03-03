-- Settings
vim.opt.spell = true

-- Keymaps
local keymap = vim.keymap
local opts = { buffer = true, silent = true }

-- Fix incorrect markdown toc entries
-- - Marksman code action don't understand links in headers
-- - change `[[...]](#...)` to `[...](#...)`
opts.desc = 'Fix TOC generated from Marksman'
keymap.set(
  'n',
  '<Leader>A1',
  [[:/^<!--toc:start-->/,/^<!--toc:end-->/s/^\( *- \)\[\[\(.\+\)\]\]\((#.\+)\)/\1\[\2\]\3/<CR>]],
  opts
)

-- Find markdown headers (from level 2)
-- - No recognition of code blocks
opts.desc = 'Find headers'
keymap.set('n', '<Leader>Ah', [[/^##\+ .\+<CR>]], opts)
opts.desc = 'Find headers to location list'
keymap.set('n', '<Leader>AH', [[:lvimgrep /^##\+ .\+/ %<CR>]], opts)
