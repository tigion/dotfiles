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

    -- Indent guides and scopes
    indent = {
      indent = { char = '┊' },
      animate = { enabled = false },
      scope = { char = '┊' },
    },

    -- Better `vim.ui.input`
    input = { enabled = true },

    -- Pretty `vim.notify`
    notifier = { enabled = true },

    -- Zen mode • distraction-free coding
    zen = {
      toggles = {
        dim = false,
        git_signs = true,
        mini_diff_signs = true,
        diagnostics = true,
        inlay_hints = false,
      },
      show = {
        statusline = true, -- can only be shown when using the global statusline
        tabline = false,
      },
      win = {
        backdrop = { transparent = false },
        -- width = 120,
      },
    },
  },

  -- Keymaps for the snacks plugin
  keys = {
    { '<Leader>tn', function() Snacks.notifier.show_history() end, desc = 'Toggle Notifier History' },
    { '<Leader>z', function() Snacks.zen.zen() end, desc = 'Toggle Zen Mode' },
    { '<Leader>Z', function() Snacks.zen.zoom() end, desc = 'Toggle Zen Zoom Mode' },
  },
}
