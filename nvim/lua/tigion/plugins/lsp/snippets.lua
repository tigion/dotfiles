return {
  'L3MON4D3/LuaSnip', -- snippet engine
  enabled = false, -- TODO: Disabled for now, use blink.nvim snippets integration instead.
  dependencies = {
    'rafamadriz/friendly-snippets', -- snippets
  },
  config = function()
    local luasnip = require('luasnip')

    -- load snippets
    require('luasnip.loaders.from_vscode').lazy_load()
    -- load user snippets
    require('luasnip.loaders.from_vscode').load({ paths = './snippets' })

    -- Navigate between snippet placeholder
    vim.keymap.set({ 'i', 's' }, '<C-f>', function() luasnip.jump(1) end, { silent = true })
    vim.keymap.set({ 'i', 's' }, '<C-b>', function() luasnip.jump(-1) end, { silent = true })
  end,
}
