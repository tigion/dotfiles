return {
  -- This plugin adds a simple session management to Neovim.
  -- Link: https://github.com/tigion/nvim-sessions

  'tigion/nvim-sessions',
  dev = false,
  keys = {
    { '<Leader>ws', '<Cmd>Session save<CR>', desc = 'Save session (cwd)' },
    { '<Leader>wl', '<Cmd>Session load<CR>', desc = 'Load session (cwd)' },
  },
  opts = {},
}
