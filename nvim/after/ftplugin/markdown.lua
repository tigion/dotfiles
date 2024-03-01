-- Keymaps
local keymap = vim.keymap

-- Fix incorrect markdown toc entries
-- - Marksman code action don't understand links in headers
-- - change `[[...]](#...)` to `[...](#...)`
keymap.set(
  'n',
  '<Leader>A1',
  [[:/^<!--toc:start-->/,/^<!--toc:end-->/s/^\( *- \)\[\[\(.\+\)\]\]\((#.\+)\)/\1\[\2\]\3/<CR>]],
  { buffer = true, silent = true, desc = 'MARKDOWN: Fix TOC generated from Marksman' }
)

-- Find markdown headers (from level 2)
-- - No recognition of code blocks
keymap.set(
  'n',
  '<Leader>Ah',
  [[/^##\+ .*<CR>]],
  { buffer = true, silent = true, desc = 'MARKDOWN: Find headers from level 2' }
)
