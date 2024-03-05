return {
  { -- comment handling
    'numToStr/Comment.nvim',
    opts = {},
    lazy = false,
  },

  { -- highlight and search for todo comments
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VimEnter',
    keys = {
      { '<Leader>xt', '<Cmd>TodoTrouble<CR>', desc = 'Trouble: Show TODO comments' },
      { 'öt', '<Cmd>TodoTelescope<CR>', desc = 'Find in TODO comments' },
    },
    opts = {
      signs = false,
    },
  },
}
