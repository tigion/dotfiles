return {
  -- This plugin adds distraction-free coding to Neovim.
  -- Link: https://github.com/folke/zen-mode.nvim

  'folke/zen-mode.nvim', -- distraction-free coding
  keys = {
    { '<Leader>z', '<Cmd>ZenMode<CR>', desc = 'Toggle zen mode', silent = true },
  },
  opts = {
    window = {
      -- width = 160,
      options = {
        -- number = false,
      },
    },
    plugins = {
      -- tmux = { enabled = true },
    },
  },
}
