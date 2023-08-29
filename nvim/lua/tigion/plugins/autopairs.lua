return {
  'windwp/nvim-autopairs', -- auto pairs (cmp, treesitter)
  event = 'InsertEnter',
  opts = {
    disable_filetype = { 'TelescopePrompt', 'vim' },
  },
}