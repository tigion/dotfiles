return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'classic', ---@type false | "classic" | "modern" | "helix"
    -- delay = 300,
    delay = function()
      local delay = 200
      -- NOTE: To make `<Leader>d` and `<Leader>dd` keymaps work
      --       make sure that opts.delay >= timeoutlen.
      --       - https://github.com/folke/which-key.nvim/issues/648#issuecomment-2226881346
      return delay < vim.o.timeoutlen and vim.o.timeoutlen or delay
    end,
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
      desc = 'Buffer Local Keymaps (which-key)',
    },
    {
      '<leader>??',
      function() require('which-key').show() end,
      desc = 'Global Keymaps (which-key)',
    },
  },
  -- config = function(_, opts)
  --   require('which-key').setup(opts)
  --   -- print(opts.delay() .. ' vs ' .. vim.o.timeoutlen)
  --
  --   -- require('which-key').add({
  --   -- })
  -- end,
}
