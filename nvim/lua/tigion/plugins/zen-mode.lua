return {
  'folke/zen-mode.nvim', -- distraction-free coding
  keys = {
    { '<Leader>z', '<Cmd>ZenMode<CR>', desc = 'Toggle zen mode', silent = true },
  },
  opts = {
    window = {
      options = {
        --number = false,
      },
    },
  },
}
