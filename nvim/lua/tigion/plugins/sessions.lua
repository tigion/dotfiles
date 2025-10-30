return {
  -- This plugin adds a simple session management to Neovim.
  -- Link: https://github.com/tigion/sessions.nvim

  'tigion/sessions.nvim',
  dev = false,
  event = 'VeryLazy',
  cmd = 'Session',
  keys = {
    { '<Leader>ws', '<Cmd>Session save<CR>', desc = 'Save session (cwd)' },
    { '<Leader>wl', '<Cmd>Session load<CR>', desc = 'Load session (cwd)' },
  },
  ---@module 'sessions'
  ---@type sessions.Config
  opts = {
    auto_save = false,
  },
}
