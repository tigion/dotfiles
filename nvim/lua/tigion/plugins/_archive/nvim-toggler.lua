return {
  -- This plugin inverts text in Neovim.
  -- Link: https://github.com/nguyenvukhang/nvim-toggler

  'nguyenvukhang/nvim-toggler',
  enabled = false,
  event = { 'BufReadPost', 'BufNewFile' },

  config = function()
    local toggler = require('nvim-toggler')

    toggler.setup({
      inverses = {
        ['>='] = '<=',
        ['>'] = '<',
      },
      remove_default_keybinds = true,
      remove_default_inverses = false,
    })

    vim.keymap.set(
      { 'n', 'x' },
      '<Leader>i',
      toggler.toggle,
      { noremap = true, silent = true, desc = 'Invert text/operand' }
    )
  end,
}
