-- Keymaps
local keymap = vim.keymap

-- Find AsciiDoc headers (from level 2)
-- - No recognition of code blocks
keymap.set(
  'n',
  '<Leader>Ah',
  [[/^==\+ .\+<CR>]],
  { buffer = true, silent = true, desc = 'ASCIIDOC: Find headers from level 2' }
)
