return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  keys = {
    -- show/navigate git hunks
    { '<Leader>gp', '<Cmd>Gitsigns preview_hunk<CR>', desc = 'Show (preview) git hunk' },
    { '+g', '<Cmd>Gitsigns next_hunk<CR>', desc = 'Next git hunk' },
    { 'üg', '<Cmd>Gitsigns prev_hunk<CR>', desc = 'Previous git hunk' },
    { '<Leader>gl', '<Cmd>Gitsigns setloclist<CR>', desc = 'Show git hunks in location list' },
    -- stage/unstage/reset git hunks
    { '<Leader>gs', '<Cmd>Gitsigns stage_hunk<CR>', desc = 'Stage git hunk' },
    { '<Leader>gu', '<Cmd>Gitsigns undo_stage_hunk<CR>', desc = 'Unstage git hunk' },
    { '<Leader>gR', '<Cmd>Gitsigns reset_hunk<CR>', desc = 'Reset git hunk' },
  },
  opts = {
    _signs_staged_enable = true, -- experimental: show dimmed signs for staged hunks
  },
}
