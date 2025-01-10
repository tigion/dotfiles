return {
  {
    -- This plugin assists with motions to navigate your current buffer in Neovim.
    -- Link: https://github.com/tris203/precognition.nvim

    'tris203/precognition.nvim',
    event = 'VeryLazy',
    keys = {
      { '<Leader>tp', '<Cmd>Precognition toggle<CR>', desc = 'Toggle Precognition' },
    },
    opts = {
      startVisible = false,
    },
  },

  {
    -- This plugin establishes a good command workflow and
    -- quits bad habits in Neovim.
    -- Link: https://github.com/m4xshen/hardtime.nvim

    'm4xshen/hardtime.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    event = 'VeryLazy',
    keys = {
      { '<Leader>tha', '<Cmd>Hardtime toggle<CR>', desc = 'Toggle Hardtime' },
    },
    opts = {
      disable_mouse = false,
      restriction_mode = 'hint',
      disabled_keys = {
        ['<Up>'] = { '' },
        ['<Down>'] = { '' },
        ['<Left>'] = { '' },
        ['<Right>'] = { '' },
      },
    },
  },
}
