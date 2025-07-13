return {
  -- {
  --   -- This plugin adds a source provider for blink.cmp to Neovim
  --   -- that allow you to use nvim-cmp completion sources.
  --   -- Link: https://github.com/saghen/blink.compat
  --
  --   -- WARN: Only for not supported native blink.cmp sources.
  --
  --   -- NOTE: Needed for:
  --   -- - ?
  --
  --   'saghen/blink.compat',
  --   version = '*',
  --   lazy = true,
  --   opts = {},
  -- },
  {
    -- This plugin adds a performant completion to Neovim.
    -- Source: https://github.com/saghen/blink.cmp
    -- Docs: https://cmp.saghen.dev/

    'saghen/blink.cmp',
    enabled = true,
    lazy = false, -- lazy loading handled internally
    version = 'v1.*',
    dependencies = {
      { 'rafamadriz/friendly-snippets' }, -- optional: provides snippets for the snippet source
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'enter',
        ['<C-y>'] = { 'select_and_accept' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
      },

      completion = {
        list = {
          selection = {
            -- No preselect for cmdline mode
            preselect = function(ctx) return ctx.mode ~= 'cmdline' end,
            -- No preselect for cmdline mode and snippet placeholders
            -- preselect = function(ctx)
            --   return ctx.mode ~= 'cmdline' and not require('blink.cmp').snippet_active({ direction = 1 })
            -- end,
            auto_insert = true,
          },
        },
        menu = {
          border = 'rounded',
          draw = {
            treesitter = { 'lsp' },
            columns = {
              { 'kind_icon' },
              { 'label', 'label_description', gap = 1 },
              { 'kind', 'source_name', gap = 1 },
            },
            -- NOTE: Columns for the cmdline are directly configured
            --       in `cmdline.menu.draw.columns`.
            --
            -- columns = function(ctx)
            --   if ctx.mode == 'cmdline' then
            --     return {
            --       { 'label', 'label_description', gap = 1 },
            --     }
            --   end
            --   return {
            --     { 'kind_icon' },
            --     { 'label', 'label_description', gap = 1 },
            --     { 'kind', 'source_name', gap = 1 },
            --   }
            -- end,
          },
        },
        documentation = {
          auto_show = true,
          window = {
            border = 'rounded',
          },
        },
      },

      fuzzy = {
        -- sorts = { 'exact', 'score', 'sort_text' },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'omni' },
        providers = {
          buffer = {
            min_keyword_length = 2,
          },
          cmdline = {
            -- Only needed if `cmdline.completion.menu.auto_show` is set to `true`
            -- min_keyword_length = function(ctx)
            --   -- only applies when typing a command, doesn't apply to arguments
            --   return ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil and 2 or 0
            -- end,
          },
        },
      },

      appearance = {
        kind_icons = require('tigion.core.icons').code,
      },

      cmdline = {
        keymap = {
          ['<Tab>'] = { 'show', 'select_next' },
          -- ['<Enter>'] = { 'select_accept_and_enter', 'fallback' },
          ['<Enter>'] = { 'select_and_accept', 'fallback' },
        },
        -- completion = { menu = { auto_show = true } },
        completion = {
          menu = {
            -- auto_show = true,
            draw = {
              columns = {
                { 'label', 'label_description', gap = 1 },
              },
            },
          },
        },
      },

      -- Experimental signature help support
      signature = { enabled = true },
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { 'sources.default' },
  },
}
