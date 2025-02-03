return {
  -- This plugin adds a collection of small QoL plugins to Neovim.
  -- Link: https://github.com/folke/snacks.nvim

  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@module 'snacks'
  ---@type snacks.Config
  opts = {
    -- bigfile = { enabled = true },
    -- dashboard = { enabled = true },
    indent = {
      indent = { char = '┊' },
      animate = { enabled = false },
      scope = { char = '┊' },
    },
    input = { enabled = true },
    -- picker = { enabled = true },
    notifier = { enabled = true },
    -- quickfile = { enabled = true },
    -- scroll = { enabled = true },
    -- statuscolumn = { enabled = true },
    -- words = { enabled = true },
  },
  keys = {
    { '<Leader>tn', function() Snacks.notifier.show_history() end, desc = 'Toggle Notifier History' },
  },
}
