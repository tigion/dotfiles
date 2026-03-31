-- nvim 0.12+

-- Highlighting color references on supporting LSP servers that implement
-- the `textDocument/documentColor` method.
-- Replaces mini.hipatterns for color highlighting.
--
-- - default style is 'background'
-- - style = 'background' | 'foreground' | 'virtual' | string | fun()
--   - 'virtual' defaults to ' '
--   - 'string' examples: ' ', '󱓻 ', ' ', '󰝤 '
vim.lsp.document_color.enable(true, nil, { style = 'virtual' }) -- `virtual` defaults to ' '
