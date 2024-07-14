return {
  { -- comment handling
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
      })

      ---@diagnostic disable-next-line missing-fields
      require('Comment').setup({
        -- hook for nvim-ts-context-commentstring
        -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#commentnvim
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end,
  },

  { -- highlight and search for todo comments
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
