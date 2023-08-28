return {
  'folke/zen-mode.nvim', -- distraction-free coding
  keys = {
    { '<Leader>z', '<cmd>ZenMode<cr>', desc = 'Toggle zen mode', silent = true },
  },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    window = {
      options = {
        --number = false,
      },
    },
  },

  -- config = function()
  --   local zenMode = require('zen-mode')
  --
  --   zenMode.setup {
  --     window = {
  --       options = {
  --         --number = false,
  --       },
  --     },
  --   }
  --   vim.keymap.set('n', '<Leader>z', '<cmd>ZenMode<cr>', { silent = true })
  -- end,
}