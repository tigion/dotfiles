return {
  {
    -- This plugin enhances Neovim's native comments.
    -- Link: https://github.com/folke/ts-comments.nvim

    'folke/ts-comments.nvim',
    opts = {},
    event = 'VeryLazy',
    enabled = vim.fn.has('nvim-0.10.0') == 1,
  },

  {
    -- This plugin adds a better annotation generator to Neovim.
    -- Link: https://github.com/danymat/neogen

    'danymat/neogen',
    keys = {
      {
        '<leader>cn',
        '<Cmd>Neogen<CR>',
        desc = 'Generate Annotations (Neogen)',
      },
    },
    opts = {
      -- snippet_engine = 'luasnip',
      snippet_engine = 'nvim',
    },
  },

  {
    -- This plugin highlights, lists and searches todo comments in your
    -- projects in Neovim.
    -- Link: https://github.com/folke/todo-comments.nvim

    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VimEnter',
    keys = {
      -- { '<Leader>xt', '<Cmd>TodoTrouble<CR>', desc = 'Trouble: Show TODO comments' },
      {
        '<Leader>xt',
        '<Cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<CR>',
        desc = 'Show TODO comments (Trouble)',
      },
      { 'öt', function() Snacks.picker.todo_comments() end, desc = 'Find in TODO comments' },
      { 'Öt', '<Cmd>TodoTelescope<CR>', desc = 'Find in TODO comments' },
    },
    opts = {
      signs = false,
    },
  },
}
