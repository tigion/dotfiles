return {
  {
    -- This plugin adds a smart and powerful commenting to Neovim.
    -- Link: https://github.com/numToStr/Comment.nvim

    'numToStr/Comment.nvim',
    -- opts = {},
    lazy = false,
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring', -- comment support for embedded languages
    },
    config = function()
      -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#plugins-with-a-pre-comment-hook
      ---@diagnostic disable-next-line missing-fields
      require('ts_context_commentstring').setup({
        enable_autocmd = false,
        languages = {
          -- NOTE: Allow single line and block comments in C files.
          -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring/issues/82#issuecomment-2213944325
          -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring/blob/main/lua/ts_context_commentstring/config.lua
          c = { __default = '// %s', __multiline = '/* %s */' }, -- default is only `c = '/* %s */'`
        },
      })

      ---@diagnostic disable-next-line missing-fields
      require('Comment').setup({
        -- hook for nvim-ts-context-commentstring
        -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#commentnvim
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end,
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
      { 'öt', '<Cmd>TodoTelescope<CR>', desc = 'Find in TODO comments' },
    },
    opts = {
      signs = false,
    },
  },
}
