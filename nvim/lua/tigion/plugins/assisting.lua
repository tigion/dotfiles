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
    event = { 'BufReadPost', 'BufNewFile' },
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
    -- This plugin extends and creates a/i textobjects in Neovim.
    -- Link: https://github.com/echasnovski/mini.ai

    -- NOTE: For text-objects like `@block.inner` is the dependency
    --       `nvim-treesitter/nvim-treesitter-textobjects` required.
    --       Extra config is in `tigion/plugins/treesitter.lua`.

    'echasnovski/mini.ai',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    version = false,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function()
      return {
        n_lines = 200,
        custom_textobjects = {
          -- o = require('mini.ai').gen_spec.treesitter({ -- code block
          --   a = { '@block.outer', '@conditional.outer', '@loop.outer' },
          --   i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          -- }),
        },
      }
    end,
  },

  {
    -- A Neovim plugin to quickly switch the word under the cursor to its opposite word.
    -- Link: https://github.com/tigion/nvim-opposites

    'tigion/nvim-opposites',
    dev = false,
    keys = {
      { '<Leader>i', function() require('opposites').switch() end, desc = 'Switch word' },
      -- { '<Leader>I', function() require('opposites').cases.switch() end, desc = 'Switch to next word' },
    },
    ---@type opposites.Config
    opts = {
      all = {
        -- modules = { 'opposites', 'cases' },
      },
      opposites = {
        words = {
          ['ja'] = 'nein',
          -- ['jo'] = 'nein',
        },
        words_by_ft = {
          markdown = {
            ['[ ]'] = '[x]',
          },
        },
      },
      cases = {
        types = { 'snake', 'screaming_snake', 'camel', 'pascal' },
      },
      chains = {
        words = {
          { 'foo', 'bar', 'baz', 'qux' },
          { '[!NOTE]', '[!TIP]', '[!IMPORTANT]', '[!WARNING]', '[!CAUTION]' }, -- Markdown (GitHub) alerts
        },
      },
      notify = {
        found = false,
        not_found = true,
      },
    },
  },
}
