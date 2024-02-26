return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  -- opts = {},
  config = function()
    require('gitsigns').setup()
    vim.keymap.set('n', '<leader>g', ':Gitsigns preview_hunk<CR>', { silent = true, desc = 'Git: Show git hunk' })
  end,
}
