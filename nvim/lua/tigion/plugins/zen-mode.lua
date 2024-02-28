return {
  'folke/zen-mode.nvim', -- distraction-free coding
  keys = {
    { '<Leader>z', '<cmd>ZenMode<cr>', desc = 'Toggle zen mode', silent = true },
  },
  opts = {
    window = {
      options = {
        --number = false,
      },
    },
  },
}
