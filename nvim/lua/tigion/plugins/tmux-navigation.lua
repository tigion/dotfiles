return {
  'alexghergh/nvim-tmux-navigation',
  event = 'VeryLazy',
  -- keys = {
  --   { '<C-h>',     '<cmd>NvimTmuxNavigateLeft<cr>',         desc = 'Got to the left pane' },
  --   { '<C-j>',     '<cmd>NvimTmuxNavigateDown<cr>',         desc = 'Got to the down pane' },
  --   { '<C-k>',     '<cmd>NvimTmuxNavigateUp<cr>',           desc = 'Got to the up pane' },
  --   { '<C-l>',     '<cmd>NvimTmuxNavigateRight<cr>',        desc = 'Got to the right pane' },
  --   { '<C-\\>',    '<cmd>NvimTmuxNavigatePrevious<cr>',     desc = 'Go to the previous pane' },
  --   { '<C-Space>', '<Cmd>NvimTmuxNavigateNavigateNext<CR>', desc = 'Got to the next pane' },
  -- },
  opts = {
    -- disable_when_zoomed = true,
    keybindings = {
      left = '<C-h>',
      down = '<C-j>',
      up = '<C-k>',
      right = '<C-l>',
      last_active = '<C-\\>',
      next = '<C-Space>',
    },
  },
}