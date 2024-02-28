return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  -- opts = {},
  config = function()
    require('gitsigns').setup()
    vim.keymap.set(
      'n',
      '<Leader>g',
      ':Gitsigns preview_hunk<CR>',
      { silent = true, desc = 'Git: Show git hunk for current line' }
    )
  end,
}
