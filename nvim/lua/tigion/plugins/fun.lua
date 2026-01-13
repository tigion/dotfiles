return {
  'tigion/games.nvim',
  enabled = require('tigion.core.util').is_allowed_on_host(),
  dev = true,
  event = 'VeryLazy',
  -- keys = {},
  opts = {
    window = {
      -- width = 1,
      -- height = 1,
      -- max = { width = 0, height = 0 },
      border = 'rounded',
      -- ignore_34_aspect_ratio = true,
    },
  },
}
