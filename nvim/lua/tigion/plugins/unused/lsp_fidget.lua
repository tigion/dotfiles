return {
  -- This plugin adds an Extensible UI for Neovim notifications and
  -- LSP progress messages to Neovim.
  -- Link: https://github.com/j-hui/fidget.nvim

  'j-hui/fidget.nvim',
  enabled = false,
  event = 'LspAttach',
  opts = {
    progress = {
      display = {
        skip_history = false,
      },
    },
    notification = {
      window = {
        border = 'rounded',
      },
    },
  },
}
