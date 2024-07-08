return {
  'danymat/neogen',
  -- Uncomment next line if you want to follow only stable versions
  -- version = "*",
  keys = {
    {
      '<leader>cn',
      '<cmd>Neogen<cr>',
      desc = 'Generate Annotations (Neogen)',
    },
  },
  opts = {
    snippet_engine = 'luasnip',
  },
  -- config = function(_, opts)
  --   require('neogen').setup(opts)
  -- end,
}
