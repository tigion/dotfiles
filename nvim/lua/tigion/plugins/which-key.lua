return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {},
  config = function(_, opts)
    require('which-key').setup(opts)

    -- TODO: keymap groups
    require('which-key').register({
      -- ['<leader>g'] = { name = 'Git', _ = 'which_key_ignore' },
      -- ['<leader>c'] = { name = 'Code', _ = 'which_key_ignore' },
      -- -- ['<leader>l'] = { name = 'LSP', _ = 'which_key_ignore' },
      -- ['<leader>t'] = { name = 'Toggle', _ = 'which_key_ignore' },
      -- ['<leader>x'] = { name = 'Trouble', _ = 'which_key_ignore' },
      -- ['ö'] = { name = 'Telescope', _ = 'which_key_ignore' },
      ['<leader>'] = {
        g = 'Git',
        c = 'Code',
        t = 'Toggle',
        x = 'Trouble',
      },
      ['ö'] = 'Telescope',
    })
  end,
}
