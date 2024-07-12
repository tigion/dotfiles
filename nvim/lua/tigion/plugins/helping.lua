return {
  {
    -- Assists with discovering motions (Both vertical and horizontal)
    -- to navigate your current buffer.
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
    -- Establish good command workflow and quit bad habit.
    'm4xshen/hardtime.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    event = 'VeryLazy',
    keys = {
      { '<Leader>?h', '<Cmd>Hardtime toggle<CR>', desc = 'Toggle Hardtime' },
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
