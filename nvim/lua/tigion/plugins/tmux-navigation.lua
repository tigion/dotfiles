return {
  'alexghergh/nvim-tmux-navigation',
  event = 'VeryLazy',
  -- stylua: ignore
  keys = {
    -- no `mode = {}` defaults to 'n'
    { '<C-h>', '<Cmd>NvimTmuxNavigateLeft<CR>', desc = 'Go to the left window/pane' },
    { '<C-j>', '<Cmd>NvimTmuxNavigateDown<CR>', desc = 'Go to the down window/pane' },
    { '<C-k>', '<Cmd>NvimTmuxNavigateUp<CR>', desc = 'Go to the up window/pane' },
    { '<C-l>', '<Cmd>NvimTmuxNavigateRight<CR>', desc = 'Go to the right window/pane' },
    { '<C-\\>', '<Cmd>NvimTmuxNavigateLastActive<CR>', desc = 'Go to the previous window/pane' },
    { '<C-Space>', '<Cmd>NvimTmuxNavigateNext<CR>', desc = 'Go to the next window/pane' },
  },
  opts = {
    -- disable_when_zoomed = true,
  },
  -- config = function(_, opts)
  --   local nvim_tmux_nav = require('nvim-tmux-navigation')
  --
  --   nvim_tmux_nav.setup(opts)
  --
  --   vim.keymap.set('n', '<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft)
  --   vim.keymap.set('n', '<C-j>', nvim_tmux_nav.NvimTmuxNavigateDown)
  --   vim.keymap.set('n', '<C-k>', nvim_tmux_nav.NvimTmuxNavigateUp)
  --   vim.keymap.set('n', '<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight)
  --   vim.keymap.set('n', '<C-\\>', nvim_tmux_nav.NvimTmuxNavigateLastActive)
  --   vim.keymap.set('n', '<C-Space>', nvim_tmux_nav.NvimTmuxNavigateNext)
  -- end,
}
