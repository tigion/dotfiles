return {
  'nguyenvukhang/nvim-toggler',
  enabled = true,
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
      { 'n', 'v' },
      '<leader>t',
      toggler.toggle,
      { noremap = true, silent = true, desc = 'Toggle (invert) text/operand' }
    )
  end,
}
