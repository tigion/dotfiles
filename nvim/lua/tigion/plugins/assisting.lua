return {
  {
    -- This plugin adds a powerful autopair to Neovim.
    -- Link: https://github.com/windwp/nvim-autopairs

    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    -- dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      local autopairs = require('nvim-autopairs')

      autopairs.setup({
        disable_filetype = { 'TelescopePrompt', 'vim' },
        check_ts = true, -- enable treesitter
        ts_config = {
          -- it will not add a pair on that treesitter filetype nodes:
          lua = { 'string' },
          javascript = { 'template_string' },
          -- don't check treesitter on filetypes:
          java = false,
        },
      })

      -- Needed for nvim-cmp:
      -- make autopairs and completion work together
      -- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      -- local cmp = require('cmp')
      -- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },

  -- {
  --   -- This plugin adds minimal and fast autopairs to Neovim.
  --   -- Link: https://github.com/echasnovski/mini.pairs
  --
  --   -- NOTE: Deactivated, needs more testing. At the moment, this plugin
  --   --       has less needed default features than nvim-autopairs.
  --
  --   'echasnovski/mini.pairs',
  --   enabled = false,
  --   version = false,
  -- },

  {
    -- This plugin uses treesitter to auto close and auto rename html tags in Neovim.
    -- Link: https://github.com/windwp/nvim-ts-autotag

    'windwp/nvim-ts-autotag',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      opts = {
        -- Defaults
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false, -- Auto close on trailing </
      },
      -- per_filetype = {},
    },
  },

  {
    -- This plugin inverts text in Neovim.
    -- Link: https://github.com/nguyenvukhang/nvim-toggler

    'nguyenvukhang/nvim-toggler',
    enabled = true,
    event = { 'BufReadPost', 'BufNewFile' },

    config = function()
      local toggler = require('nvim-toggler')

      toggler.setup({
        inverses = {
          ['>='] = '<=',
          ['>'] = '<',
        },
        remove_default_keybinds = true,
        remove_default_inverses = false,
      })

      vim.keymap.set(
        { 'n', 'x' },
        '<Leader>i',
        toggler.toggle,
        { noremap = true, silent = true, desc = 'Invert text/operand' }
      )
    end,
  },
}
