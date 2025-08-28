return {
  {
    -- This plugin helps you to remember your Neovim keymaps in Neovim.
    -- Link: https://github.com/folke/which-key.nvim

    'folke/which-key.nvim',
    dependencies = { 'nvim-mini/mini.icons' },
    event = 'VeryLazy',
    opts = {
      preset = 'helix', ---@type false | "classic" | "modern" | "helix"
      delay = 300,
      -- icons = {
      --   rules = false,
      -- },
      expand = 2, -- expand groups with max 2 child keymaps
      spec = {
        { '<Esc>', hidden = true },
        -- { '<Leader>', group = '' },
        { '<Leader>c', group = 'Code' },
        { '<Leader>g', group = 'Git' },
        { '<Leader>t', group = 'Toggle' },
        { '<Leader>x', group = 'Trouble' },
        { 'ö', group = 'Find (Snacks.picker)' },
        { 'Ö', group = 'Find (Telescope)' },
      },
    },
    keys = {
      {
        '<leader>?',
        function() require('which-key').show({ global = false }) end,
        desc = 'Local buffer keymaps',
      },
      {
        '<leader>??',
        function() require('which-key').show() end,
        desc = 'Global keymaps',
      },
    },
  },

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
