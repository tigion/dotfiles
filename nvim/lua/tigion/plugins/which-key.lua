return {
  'folke/which-key.nvim',
  dependencies = { 'echasnovski/mini.icons' },
  event = 'VeryLazy',
  opts = {
    -- preset = 'classic', ---@type false | "classic" | "modern" | "helix"
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
      { 'ö', group = 'Find (Telescope)' },
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
}
