return {
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
      -- 'onsails/lspkind-nvim', -- vscode-like pictograms
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
  {
    'onsails/lspkind-nvim', -- vscode-like pictograms
    lazy = true,
    config = function()
      local lspkind = require('lspkind')

      local icons = require('tigion.core.icons')
      local symbol_map = {}
      for kind, icon in pairs(icons.code) do
        symbol_map[kind] = icon
      end

      lspkind.init({
        -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
        mode = 'symbol_text',
        preset = 'codicons',
        -- override preset symbols
        symbol_map = symbol_map,
      })
    end,
  },
}
