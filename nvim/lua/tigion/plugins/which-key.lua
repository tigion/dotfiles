return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'classic', ---@type false | "classic" | "modern" | "helix"
    delay = 300,
    -- icons = {
    --   rules = false,
    -- },
    expand = 1,
    spec = {
      { '<Esc>', hidden = true },
      { '<Leader>c', group = 'Code' },
      { '<Leader>g', group = 'Git' },
      { '<Leader>t', group = 'Toggle' },
      { '<Leader>x', group = 'Trouble' },
      { 'ö', group = 'Telescope' },
    },
  },
  keys = {
    {
      '<leader>?',
      function() require('which-key').show({ global = false }) end,
      desc = 'Local buffer keymaps (which-key)',
    },
    {
      '<leader>??',
      function() require('which-key').show() end,
      desc = 'Global keymaps (which-key)',
    },
  },
}
