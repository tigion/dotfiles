return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  -- opts = {},
  config = function()
    require('gitsigns').setup()
    vim.keymap.set('n', '<leader>ph', ':Gitsigns preview_hunk<CR>', { silent = true })
  end,
}