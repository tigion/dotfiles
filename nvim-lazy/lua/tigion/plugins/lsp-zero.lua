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
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },

    -- Snippets
    { 'L3MON4D3/LuaSnip' },
    { 'rafamadriz/friendly-snippets' },

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
      'tsserver', -- TypeScript
      'eslint',   -- JavaScript, TypeScript
      'lua_ls',   -- Lua
      'cssls',    -- CSS, SCSS, LESS
      'clangd',   -- C, C++
      'bashls',   -- Bash (LSP)
      'marksman', -- Markdown
      'pyright',  -- Python
      'vimls',    -- VimScript
      'yamlls',   -- Yaml
      'html',     -- HTML
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
            enable = true, -- format with sumneko_lua (settings: .editorconfig) instead of stylua (null-ls)
          },
          diagnostics = {
            globals = { 'vim' },
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
    ----local cmp_select = {behavior = cmp.SelectBehavior.Select}
    local cmp_mappings = lsp.defaults.cmp_mappings {
      --['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
      --['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
      --['<C-y>'] = cmp.mapping.confirm({ select = true }),
      ['<C-Space>'] = cmp.mapping.complete(),
    }
    -- disable completion with tab
    -- this helps with copilot setup
    --cmp_mappings['<Tab>'] = nil
    --cmp_mappings['<S-Tab>'] = nil
    --lsp.setup_nvim_cmp {
    --	mapping = cmp_mappings,
    --}

    lsp.set_preferences {
      suggest_lsp_servers = true,
    }

    lsp.on_attach(function(client, bufnr)
      local opts = { buffer = bufnr, remap = false }

      if client.name == 'eslint' then
        vim.cmd.LspStop 'eslint'
        return
      end

      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
      vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', 'üd', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '+d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
      vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
    end)

    lsp.setup()

    vim.diagnostic.config {
      virtual_text = true,
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
        null_ls.builtins.diagnostics.flake8.with { extra_args = { '--max-line-length', '88' } },
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