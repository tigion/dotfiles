return {
  -- This plugin adds a easy Neovim-Tmux navigation to Neovim.
  -- Link: https://github.com/alexghergh/nvim-tmux-navigation

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
}
