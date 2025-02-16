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
    -- Link: https://github.com/saghen/blink.cmp

    'saghen/blink.cmp',
    enabled = true,
    lazy = false, -- lazy loading handled internally
    version = 'v0.*',
    dependencies = {
      { 'rafamadriz/friendly-snippets' }, -- optional: provides snippets for the snippet source
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    ---@diagnostic disable: missing-fields
    opts = {
      -- disable cmp for specific filetypes
      enabled = function()
        return not vim.tbl_contains({}, vim.bo.filetype)
          and vim.bo.buftype ~= 'nofile'
          and vim.bo.buftype ~= 'prompt'
          and vim.b.completion ~= false
      end,

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
        -- use_typo_resistance = false,
        -- max_typos = 0.0,
        -- max_typos = function(keyword) return math.floor(#keyword / 4) end,
        -- max_typos = function() return 0.0 end,
        -- sorts = { 'exact', 'score', 'sort_text' },
      },

      -- default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, via `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'omni' },
        providers = {
          snippets = {
            -- min_keyword_length = 1,
            -- opts = {
            --   friendly_snippets = true,
            --   search_paths = { vim.fn.stdpath('config') .. '/snippets' },
            -- },
          },
          buffer = {
            min_keyword_length = 2,
          },
          cmdline = {
            -- min_keyword_length = 2,
            min_keyword_length = function(ctx)
              -- only applies when typing a command, doesn't apply to arguments
              return string.find(ctx.line, ' ') == nil and 2 or 0
            end,
          },
        },
      },

      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono',
        kind_icons = require('tigion.core.icons').code,
      },

      cmdline = {
        keymap = {
          preset = 'enter',
          ['<S-Tab>'] = { 'select_prev', 'fallback' },
          ['<Tab>'] = { 'select_next', 'fallback' },
        },
      },
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { 'sources.default' },
  },
}
