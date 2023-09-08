return {
  'VonHeikemen/lsp-zero.nvim',
  --enabled = false,
  branch = 'v2.x',
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' },             -- Required
    { 'williamboman/mason.nvim' },           -- Optional
    { 'williamboman/mason-lspconfig.nvim' }, -- Optional

    -- -- Autocompletion
    -- { 'hrsh7th/nvim-cmp' },   -- Required
    -- { 'hrsh7th/cmp-nvim-lsp' }, -- Required
    -- { 'L3MON4D3/LuaSnip' },   -- Required

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },

    -- Snippets
    { 'L3MON4D3/LuaSnip' },             -- snippet engine
    { 'saadparwaiz1/cmp_luasnip' },     -- autocompletion
    { 'rafamadriz/friendly-snippets' }, -- snippets

    -- user (tigion) settings
    { 'jose-elias-alvarez/null-ls.nvim' },                          --
    { 'onsails/lspkind-nvim' },                                     -- vscode-like pictograms
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },                -- helper for mason to preinstall packages like 'shellsheck' which are not LSPs
    { 'j-hui/fidget.nvim',                        tag = 'legacy' }, -- LSP status view
  },
  config = function()
    local status, lsp = pcall(require, 'lsp-zero')
    if not status then return end

    lsp.preset 'recommended'

    -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
    lsp.ensure_installed {
      'bashls',   -- Bash (LSP)
      'clangd',   -- C, C++
      'cssls',    -- CSS, SCSS, LESS
      --'eslint',   -- JavaScript, TypeScript
      'html',     -- HTML
      'lua_ls',   -- Lua
      'marksman', -- Markdown
      'phpactor', -- PHP
      'pyright',  -- Python
      'tsserver', -- JavaScript, TypeScript
      'vimls',    -- VimScript
      'yamlls',   -- Yaml
    }

    -- helper functions
    local augroup_format = vim.api.nvim_create_augroup('Format', { clear = true })
    local enable_format_on_save = function(_, bufnr)
      vim.api.nvim_clear_autocmds { group = augroup_format, buffer = bufnr }
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup_format,
        buffer = bufnr,
        callback = function() vim.lsp.buf.format { bufnr = bufnr } end,
      })
    end

    -- lua settings
    lsp.configure('lua_ls', {
      -- Add format on save
      on_attach = function(client, bufnr) enable_format_on_save(client, bufnr) end,
      -- Fix Undefined global 'vim'
      settings = {
        Lua = {
          format = {
            enable = true, -- format with lua_ls (settings: .editorconfig) instead of stylua (null-ls)
          },
          diagnostics = {
            -- recognize "vim" global
            globals = { 'vim' },
          },
          workspace = {
            -- aware runtime files
            library = {
              [vim.fn.expand('$VIMRUNTIME/lua')] = true,
              [vim.fn.stdpath('config') .. '/lua'] = true,
            },
          },
        },
      },
    })

    -- html (html-lsp)
    lsp.configure('html', {
      settings = {
        html = {
          format = {
            templating = true,
            wrapLineLength = 0,
          },
        },
      },
    })

    -- cmp mappings
    local cmp = require 'cmp'
    --local cmp_select = { behavior = cmp.SelectBehavior.Select }
    local cmp_mappings = lsp.defaults.cmp_mappings {
      --['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
      --['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
      --['<C-y>'] = cmp.mapping.confirm({ select = true }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      -- TODO: <S-CR> Don't work in Tmux => fallback <C+r>
      ['<S-CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      ['<C-r>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      ['<C-Space>'] = cmp.mapping.complete(),
    }

    -- disable completion with tab
    -- this helps with copilot setup
    --cmp_mappings['<Tab>'] = nil
    --cmp_mappings['<S-Tab>'] = nil

    -- set new mappings
    lsp.setup_nvim_cmp {
      mapping = cmp_mappings,
    }

    lsp.set_preferences {
      suggest_lsp_servers = true,
    }

    lsp.on_attach(function(client, bufnr)
      local opts = { buffer = bufnr, remap = false, silent = false }
      local keymap = vim.keymap

      if client.name == 'eslint' then
        vim.cmd.LspStop 'eslint'
        return
      end

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
      keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts) -- smart rename

      opts.desc = 'Show buffer diagnostics'
      keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts) -- show  diagnostics for file

      opts.desc = 'Show line diagnostics'
      -- keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
      keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts) -- show diagnostics for line

      opts.desc = 'Go to previous diagnostic'
      -- keymap.set('n', '+d', vim.diagnostic.goto_prev, opts)
      keymap.set('n', '[d', vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

      opts.desc = 'Go to next diagnostic'
      -- keymap.set('n', 'üd', vim.diagnostic.goto_next, opts)
      keymap.set('n', ']d', vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

      opts.desc = 'Show documentation for what is under cursor'
      -- keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = 'Restart LSP'
      keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts) -- mapping to restart lsp if necessary
    end)

    lsp.setup()

    -- set diagnostic icons
    for name, icon in pairs(require('tigion.core.icons').diagnostics) do
      name = 'DiagnosticSign' .. name
      vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
    end
    vim.diagnostic.config {
      virtual_text = true,
      signs = true,
    }

    -- user (tigion) settings

    require 'mason-tool-installer'.setup {
      ensure_installed = {
        'shellcheck', -- Shell (Linter)
        'shfmt',      -- Shell (Formater)
        'prettier',   -- Code (Formater)
        'stylua',     -- Lua (Formater)
        'flake8',     -- Python (Formater)
        'black',      -- Python (Formater)
        'pint',       -- PHP (Formater)
      },
    }

    local null_ls = require 'null-ls'
    local null_opts = lsp.build_options('null-ls', {})
    null_ls.setup {
      on_attach = null_opts.on_attach,
      --on_attach = function(client, bufnr)
      --  null_opts.on_attach(client, bufnr)
      --  --- ...
      --end,
      sources = {
        null_ls.builtins.formatting.trim_newlines,
        null_ls.builtins.formatting.trim_whitespace,
        --null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.prettier,
        --null_ls.builtins.formatting.stylua, -- dont work
        null_ls.builtins.formatting.shfmt, -- (settings: .editorconfig)
        null_ls.builtins.formatting.pint.with {
          command = 'pint',
          --extra_args = { '--preset', 'psr12' }, -- laravel (default), psr12, symfony
        },
        null_ls.builtins.diagnostics.flake8.with { extra_args = { '--max-line-length', '88', '--extend-ignore', 'E501' } },
        null_ls.builtins.formatting.black,
        --null_ls.builtins.formatting.black.with { extra_args = { '--skip-string-normalization' } },
        --null_ls.builtins.formatting.black.with { extra_args = { '--line-length=120', '--skip-string-normalization' } },
      },
    }

    local lspkind = require 'lspkind'
    cmp.setup {
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text',  -- show only symbol annotations
          maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

          -- The function below will be called before any actual modifications from lspkind
          -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
          -- before = function (entry, vim_item)
          --   ...
          --   return vim_item
          -- end
        }),
      },
    }
  end,
}