return {
  -- TODO: Update keymaps.md with cmp mappings and cleanup (remove unused nvim-cmp mappings)
  {
    'saghen/blink.cmp',
    enabled = true,
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    dependencies = 'rafamadriz/friendly-snippets',

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
        menu = {
          border = 'rounded',
          draw = {
            treesitter = true,
            -- columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
            columns = {
              { 'kind_icon' },
              { 'label', 'label_description', gap = 1 },
              { 'kind_icon', 'kind', gap = 1 },
              { 'source_name' },
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
        -- default = { 'lsp', 'snippets', 'buffer', 'path' },
        completion = {
          enabled_providers = { 'lsp', 'snippets', 'buffer', 'path' },
        },
        -- optionally disable cmdline completions
        -- cmdline = {},
        providers = {
          snippets = {
            min_keyword_length = 1,
            -- opts = {
            --   friendly_snippets = true,
            --   search_paths = { vim.fn.stdpath('config') .. '/snippets' },
            -- },
          },
        },
      },

      appearance = {
        -- use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
        kind_icons = require('tigion.core.icons').code,
      },
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    -- opts_extend = { 'sources.default' },
    opts_extend = { 'sources.completion.enabled_providers' },
  },
  {
    'hrsh7th/nvim-cmp',
    enabled = false,
    dependencies = {
      'hrsh7th/cmp-buffer', -- source for buffer words
      'hrsh7th/cmp-path', -- source for file and folder paths
      'hrsh7th/cmp-nvim-lsp', -- source for neovim's built-in language server client
      'saadparwaiz1/cmp_luasnip', -- source for LuaSnip snippets
      -- 'hrsh7th/cmp-cmdline', -- source for vim's cmdline
      -- 'dmitmel/cmp-cmdline-history', -- source for cmdline history
      'hrsh7th/cmp-calc',
      'onsails/lspkind-nvim', -- vscode-like pictograms
      'folke/lazydev.nvim', -- NOTE: Is here needed to get source `lazydev` from lsp.lua to work
    },
    opts = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')

      return {
        completion = {
          completeopt = 'menu,menuone,preview,noselect',
        },
        snippet = { -- configure how nvim-cmp interacts with snippet engine
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          completion = cmp.config.window.bordered({
            winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:None',
            col_offset = -1,
          }),
          -- documentation = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered({
            winhighlight = 'Normal:CmpDocumentation,FloatBorder:CmpDocumentationBorder,CursorLine:CursorLine,Search:None',
          }),
        },
        sources = cmp.config.sources({ -- check with `:CmpStatus`
          { name = 'nvim_lsp' }, -- lsp server
          { name = 'luasnip' }, -- snippets
          -- { name = 'supermaven' }, -- supermaven
          -- { name = 'codeium', max_item_count = 5 }, -- codeium
          { name = 'buffer', keyword_length = 3, max_item_count = 10 }, -- buffer words
          { name = 'path' }, -- files, paths
          { name = 'calc' }, -- math calculation
        }),
        mapping = cmp.mapping.preset.insert({
          -- defaults:
          -- <C-y>: Confirms selection
          -- <C-e>: Cancel completion
          -- <Down>: Navigate to the next item on the list
          -- <Up>: Navigate to previous item on the list
          -- <C-n>: If the completion menu is visible, go to the next item. Else, trigger completion menu.
          -- <C-p>: If the completion menu is visible, go to the previous item. Else, trigger completion menu.

          -- Navigate between suggestions
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),

          -- Confirm completion
          ['<CR>'] = cmp.mapping.confirm({ select = true }),

          -- Confirm completion with replace
          -- TODO: <S-CR> Don't work in Tmux => fallback <C-r>
          ['<S-CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
          ['<C-r>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),

          -- Trigger completion menu
          ['<C-Space>'] = cmp.mapping.complete(),

          -- Navigate between snippet placeholder
          -- ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          -- ['<C-b>'] = cmp_action.luasnip_jump_backward(),

          -- Scroll up and down in the completion documentation
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
        }),
        --- (Optional) Show source name in completion menu
        -- formatting = cmp_format,
        ---@diagnostic disable-next-line missing-fields
        formatting = {
          -- fields = { 'abbr', 'kind', 'menu' },
          format = lspkind.cmp_format({
            mode = 'symbol_text', -- 'text', 'text_symbol', 'symbol_text', 'symbol'
            menu = {
              nvim_lsp = '[lsp]',
              lazydev = '[lazydev]',
              luasnip = '[luasnip]',
              supermaven = '[supermaven]',
              codeium = '[codeium]',
              buffer = '[buffer]',
              path = '[path]',
              calc = '[calc]',
            },
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '…', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          }),
        },
      }
    end,
    -- config = function(_, opts)
    --   local cmp = require('cmp')
    --   cmp.setup(opts)
    -- end,
  },
}
