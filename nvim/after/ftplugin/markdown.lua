-- Keymaps
local keymap = vim.keymap

-- Fix incorrect markdown toc entries
-- - Marksman code action don't understand links in headers
-- - change `[[...]](#...)` to `[...](#...)`
keymap.set(
  'n',
  '<Leader>A1',
  [[:/^<!--toc:start-->/,/^<!--toc:end-->/s/^\( *- \)\[\[\(.\+\)\]\]\((#.\+)\)/\1\[\2\]\3/<CR>]],
  { desc = 'Fix markdown toc' }
)
