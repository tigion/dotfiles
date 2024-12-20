return {
  -- TODO: Update keymaps.md with cmp mappings and cleanup (remove unused nvim-cmp mappings)
  {
    'saghen/blink.cmp',
    enabled = true,
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    version = 'v0.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    ---@diagnostic disable: missing-fields
    opts = {
      keymap = {
        preset = 'enter',
        ['<C-y>'] = { 'select_and_accept' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
      },

      completion = {
        list = {
          selection = 'auto_insert',
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
          },
        },

        documentation = {
          auto_show = true,
          window = {
            border = 'rounded',
          },
        },
      },

      -- default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, via `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        -- optionally disable cmdline completions
        -- cmdline = {},
        providers = {
          snippets = {
            -- min_keyword_length = 1,
            -- opts = {
            --   friendly_snippets = true,
            --   search_paths = { vim.fn.stdpath('config') .. '/snippets' },
            -- },
          },
          buffer = {
            min_keyword_length = 3,
          },
          cmdline = {
            min_keyword_length = 2,
          },
        },
      },

      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono',
        kind_icons = require('tigion.core.icons').code,
      },
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { 'sources.default' },
  },
}
