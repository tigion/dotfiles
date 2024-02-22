return {
  'VonHeikemen/lsp-zero.nvim',
  -- enabled = false,
  branch = 'v3.x',
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' }, -- Required
    { 'williamboman/mason.nvim' }, -- Optional
    { 'williamboman/mason-lspconfig.nvim' }, -- Optional

    -- -- Autocompletion
    -- { 'hrsh7th/nvim-cmp' },   -- Required
    -- { 'hrsh7th/cmp-nvim-lsp' }, -- Required
    -- { 'L3MON4D3/LuaSnip' },   -- Required

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-buffer' }, -- source for buffer words
    { 'hrsh7th/cmp-path' }, -- source for file and folder paths
    { 'hrsh7th/cmp-nvim-lsp' }, -- source for neovim's built-in language server client
    { 'hrsh7th/cmp-nvim-lua' }, -- source for neovim Lua API

    -- Snippets
    { 'L3MON4D3/LuaSnip' }, -- snippet engine
    { 'saadparwaiz1/cmp_luasnip' }, -- autocompletion
    { 'rafamadriz/friendly-snippets' }, -- snippets

    -- user (tigion) settings
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' }, -- helper for mason to preinstall packages like 'shellsheck' which are not LSPs
    { 'onsails/lspkind-nvim' }, -- vscode-like pictograms

    {
      'j-hui/fidget.nvim', -- LSP status view
      event = 'LspAttach',
      opts = {},
    },
  },
  config = function()
    local lsp_zero = require('lsp-zero')

    lsp_zero.on_attach(function(client, bufnr)
      local opts = { buffer = bufnr, remap = false, silent = false }
      local keymap = vim.keymap

      -- https://github.com/nvim-telescope/telescope.nvim#pickers
      -- :Telescope builtin

      keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)

      opts.desc = 'Show LSP symbols'
      -- Telescope lsp_document_symbols
      -- Telescope lsp_workspace_symbols / lsp_dynamic_workspace_symbols
      keymap.set('n', 'gs', '<cmd>Telescope lsp_workspace_symbols<CR>', opts) -- show lsp definitions
      -- keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)

      opts.desc = 'Show LSP references'
      -- keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
      keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts) -- show definition, references

      opts.desc = 'Go to declaration'
      keymap.set('n', 'gD', vim.lsp.buf.declaration, opts) -- go to declaration

      opts.desc = 'Show LSP definitions'
      --keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts) -- show lsp definitions

      opts.desc = 'Show LSP implementations'
      keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts) -- show lsp implementations

      opts.desc = 'Show LSP type definitions'
      keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts) -- show lsp type definitions

      opts.desc = 'See available code actions'
      -- keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
      keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

      opts.desc = 'Smart rename'
      -- keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
      -- keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts) -- smart rename
      keymap.set(
        'n',
        '<leader>rn',
        function() return ':IncRename ' .. vim.fn.expand('<cword>') end,
        { desc = opts.desc, expr = true }
      )

      opts.desc = 'Show buffer diagnostics'
      keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts) -- show  diagnostics for file

      opts.desc = 'Show line diagnostics'
      -- keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
      keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts) -- show diagnostics for line

      opts.desc = 'Go to previous diagnostic'
      -- keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      keymap.set('n', 'üd', vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

      opts.desc = 'Go to next diagnostic'
      -- keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      keymap.set('n', '+d', vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

      opts.desc = 'Show documentation for what is under cursor'
      -- keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = 'Restart LSP'
      keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts) -- mapping to restart lsp if necessary
    end)

    -- Mason
    require('mason').setup({})
    require('mason-lspconfig').setup({
      ensure_installed = {
        -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
        'bashls', -- Bash (LSP)
        'clangd', -- C, C++
        'cssls', -- CSS, SCSS, LESS
        --'eslint',   -- JavaScript, TypeScript
        'html', -- HTML
        'lua_ls', -- Lua
        'marksman', -- Markdown
        'phpactor', -- PHP
        'pyright', -- Python
        'tsserver', -- JavaScript, TypeScript
        'vimls', -- VimScript
        'yamlls', -- Yaml
      },
      automatic_installation = true,
      handlers = {
        lsp_zero.default_setup,

        html = function()
          require('lspconfig').html.setup({
            settings = {
              html = {
                format = {
                  templating = true,
                  wrapLineLength = 0,
                },
              },
            },
          })
        end,

        lua_ls = function()
          -- helper functions
          local augroup_format = vim.api.nvim_create_augroup('Format', { clear = true })
          local enable_format_on_save = function(_, bufnr)
            vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup_format,
              buffer = bufnr,
              callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
            })
          end
          local lua_opts = lsp_zero.nvim_lua_ls({
            -- Add format on save
            -- on_attach = function(client, bufnr)
            --   enable_format_on_save(client, bufnr)
            -- end,
            -- Fix Undefined global 'vim'
            settings = {
              Lua = {
                format = {
                  enable = true, -- format with lua_ls (settings: .editorconfig) instead of stylua (null-ls)
                },
                diagnostics = {
                  globals = { 'vim' }, -- recognize "vim" global
                },
                workspace = {
                  library = { -- aware runtime files
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.stdpath('config') .. '/lua'] = true,
                  },
                },
              },
            },
          })
          require('lspconfig').lua_ls.setup(lua_opts)
        end,
      },
    })

    require('mason-tool-installer').setup({
      ensure_installed = {
        'shellcheck', -- Shell (Linter)
        'shfmt', -- Shell (Formater)
        'prettier', -- Code (Formater)
        'stylua', -- Lua (Formater)
        'ruff', -- Python (Linter)
        'flake8', -- Python (Linter)
        'pylint', -- Python (Linter)
        'black', -- Python (Formater)
        'isort', -- Python (Formatter: includes)
        'pint', -- PHP (Formater)
        'eslint_d', -- JS/TS (Linter)
        'markdownlint', -- Markdown (Linter)
      },
    })

    -- cmp mappings
    local cmp = require('cmp')
    local cmp_action = require('lsp-zero').cmp_action()
    local cmp_format = require('lsp-zero').cmp_format()

    require('luasnip.loaders.from_vscode').lazy_load()

    cmp.setup({
      window = {
        -- documentation = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered({
          winhighlight = 'Normal:Normal,CursorLine:CursorLine,Search:None',
        }),
        -- completion = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered({
          winhighlight = 'Normal:Normal,CursorLine:CursorLine,Search:None',
        }),
      },
      sources = {
        { name = 'nvim_lsp' }, -- lsp server
        { name = 'nvim_lua' }, -- neovim lua API
        { name = 'luasnip' }, -- snippets
        { name = 'buffer' }, -- buffer words
        { name = 'path' }, -- files, paths
      },
      mapping = cmp.mapping.preset.insert({
        -- defaults:
        -- <Ctrl-y>: Confirms selection
        -- <Ctrl-e>: Cancel completion
        -- <Down>: Navigate to the next item on the list
        -- <Up>: Navigate to previous item on the list
        -- <Ctrl-n>: If the completion menu is visible, go to the next item. Else, trigger completion menu.
        -- <Ctrl-p>: If the completion menu is visible, go to the previous item. Else, trigger completion menu.

        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        -- TODO: <S-CR> Don't work in Tmux => fallback <C+r>
        ['<S-CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        ['<C-r>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),

        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
      }),
      --- (Optional) Show source name in completion menu
      formatting = cmp_format,
    })

    -- LSPKIND
    local lspkind = require('lspkind')
    cmp.setup({
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text', -- show only symbol annotations
          maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
        }),
      },
    })

    -- set diagnostic icons
    for name, icon in pairs(require('tigion.core.icons').diagnostics) do
      name = 'DiagnosticSign' .. name
      vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
    end
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
    })

    -- ignore diagnostic infos for `.env` files
    vim.cmd([[autocmd BufRead,BufNewFile .env,.env.* lua vim.diagnostic.disable(0)]])
  end,
}