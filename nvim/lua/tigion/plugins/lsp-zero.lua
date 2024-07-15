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
    -- { 'hrsh7th/cmp-nvim-lua' }, -- source for neovim Lua API <- not needed, because: 'folke/neodev.nvim'
    -- { 'hrsh7th/cmp-cmdline' }, -- source for vim's cmdline
    -- { 'dmitmel/cmp-cmdline-history' }, -- source for cmdline history

    -- Snippets
    { 'L3MON4D3/LuaSnip' }, -- snippet engine
    { 'saadparwaiz1/cmp_luasnip' }, -- autocompletion
    { 'rafamadriz/friendly-snippets' }, -- snippets

    -- user (tigion) settings
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' }, -- helper for mason to preinstall packages like 'shellsheck' which are not LSPs
    { 'onsails/lspkind-nvim' }, -- vscode-like pictograms

    -- lazydev (neodev)
    -- neovim < 0.10
    -- { 'folke/neodev.nvim', opts = {} }, -- setup for init.lua and plugin development for -> lua_ls
    -- neovim >= 0.10
    {
      'folke/lazydev.nvim',
      ft = 'lua', -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        },
      },
    },
    { 'Bilal2453/luvit-meta', lazy = true }, -- optional `vim.uv` typings
    { -- optional completion source for require statements and module annotations
      'hrsh7th/nvim-cmp',
      opts = function(_, opts)
        opts.sources = opts.sources or {}
        table.insert(opts.sources, {
          name = 'lazydev',
          group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        })
      end,
    },

    {
      'j-hui/fidget.nvim', -- LSP status view
      event = 'LspAttach',
      opts = {},
    },
  },
  config = function()
    local lsp_zero = require('lsp-zero')

    lsp_zero.on_attach(function(_, bufnr)
      local opts = { buffer = bufnr, remap = false, silent = false }
      local icon_telescope = require('tigion.core.icons').telescope
      local keymap = vim.keymap

      -- https://github.com/neovim/neovim/discussions/25711
      opts.desc = 'LSP: Show hover information'
      keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- calling twice jumps into hover message
      -- keymap.set('i', '<C-k>', vim.lsp.buf.hover, opts)
      opts.desc = 'LSP: Show signature help'
      keymap.set('n', 'gK', vim.lsp.buf.signature_help, opts) -- ? default in nvim v0.10
      keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)

      opts.desc = 'LSP: ' .. icon_telescope .. ' Show document symbols'
      keymap.set('n', 'gs', '<Cmd>Telescope lsp_document_symbols<CR>', opts)
      -- keymap.set('n', '<Leader>gs', vim.lsp.buf.document_symbol, opts)

      opts.desc = 'LSP: ' .. icon_telescope .. ' Show workspace symbols'
      keymap.set('n', 'gss', '<Cmd>Telescope lsp_workspace_symbols<CR>', opts)
      -- Telescope lsp_workspace_symbols / lsp_dynamic_workspace_symbols
      -- keymap.set('n', '<Leader>gss', vim.lsp.buf.workspace_symbol, opts)

      opts.desc = 'LSP: ' .. icon_telescope .. ' Show references'
      keymap.set('n', 'gr', '<Cmd>Telescope lsp_references<CR>', opts)
      -- keymap.set('n', '<Leader>vrr', vim.lsp.buf.references, opts)

      opts.desc = 'LSP: ' .. icon_telescope .. ' Go to definition(s)'
      keymap.set('n', 'gd', '<Cmd>Telescope lsp_definitions<CR>', opts)
      --keymap.set('n', 'gd', vim.lsp.buf.definition, opts) -- jumps to the definition

      opts.desc = 'LSP: Go to declaration'
      keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

      opts.desc = 'LSP: ' .. icon_telescope .. ' Go to type definition(s)'
      keymap.set('n', 'gdt', '<Cmd>Telescope lsp_type_definitions<CR>', opts)
      -- keymap.set('n', 'gdt', vim.lsp.buf.type_definition, opts)

      opts.desc = 'LSP: ' .. icon_telescope .. ' Go to implementation(s)'
      keymap.set('n', 'gI', '<Cmd>Telescope lsp_implementations<CR>', opts)
      -- keymap.set('n', 'gI', vim.lsp.buf.implementation, opts)

      opts.desc = 'LSP: Show code actions'
      keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts) -- in visual mode will apply to selection

      -- Deactivated: See inc-rename.lua (inc-rename.nvim)
      -- opts.desc = 'LSP: Rename with all references'
      -- keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
      opts.desc = 'LSP: Rename with all references'
      keymap.set('n', '<Leader>Rn', vim.lsp.buf.rename, opts)

      -- Deactivated: See formatting.lua (conform.nvim)
      -- opts.desc = 'LSP: Format current buffer'
      -- keymap.set('n', '<Leader>f', vim.lsp.buf.format, opts)

      opts.desc = 'Show diagnostics for current line'
      keymap.set('n', '<Leader>d', vim.diagnostic.open_float, opts)
      opts.desc = icon_telescope .. ' Show diagnostics for current buffer'
      keymap.set('n', '<Leader>dd', '<Cmd>Telescope diagnostics bufnr=0<CR>', opts)
      opts.desc = icon_telescope .. ' Show diagnostics for all buffers'
      keymap.set('n', '<Leader>da', '<Cmd>Telescope diagnostics<CR>', opts)

      opts.desc = 'Next diagnostic'
      keymap.set('n', '+d', vim.diagnostic.goto_next, opts)
      opts.desc = 'Previous diagnostic'
      keymap.set('n', 'üd', vim.diagnostic.goto_prev, opts)

      opts.desc = 'LSP: Restart LSP servers for current buffer'
      keymap.set('n', '<Leader>rs', ':LspRestart<CR>', opts)
    end)

    -- Mason
    require('mason').setup({})
    require('mason-lspconfig').setup({
      ensure_installed = {
        'bashls', -- Bash (LSP)
        'clangd', -- C, C++
        'cssls', -- CSS, SCSS, LESS
        'html', -- HTML
        'jdtls', -- Java
        'lua_ls', -- Lua
        'marksman', -- Markdown
        'phpactor', -- PHP
        'pyright', -- Python
        'tsserver', -- JavaScript, TypeScript
        'vimls', -- VimScript

        -- FIX: There is a problem with LSP config for 'volar' in since version 2.0.0
        --      valor@1.8.27: no extra config needed, `K` and `Inc_Rename` work fine
        --      valor@2.0.0: extra config needed, `K`, `:lua vim.lsp.buf.rename()` works but `Inc_Rename` don't work
        --
        --      Workaround 1: Pin to version @1.8.27
        --      - `:MasonInstall vue-language-server@1.8.27`
        --      - mason-tool-installer (line 231)
        --      - `{ 'volar', version = '1.8.27' },`
        --
        --      Workaround 2: Use extra config but with no rename support
        'volar', -- Vue.js

        'yamlls', -- Yaml
      },
      automatic_installation = true,
      handlers = {
        lsp_zero.default_setup,
        -- function(server_name) require('lspconfig')[server_name].setup({}) end,

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

        -- FIX: Extra config for `valor` since version 2.0.0
        --      - https://lsp-zero.netlify.app/v3.x/guide/configure-volar-v2.html
        --      - https://github.com/vuejs/language-tools?tab=readme-ov-file#community-integration
        --
        -- Hybrid mode configuration (Requires @vue/language-server version ^2.0.0)
        -- tsserver = function()
        --   local vue_language_server_path = require('mason-registry')
        --     .get_package('vue-language-server')
        --     :get_install_path() .. '/node_modules/@vue/language-server'
        --   local vue_typescript_plugin = require('mason-registry').get_package('vue-language-server'):get_install_path()
        --     .. '/node_modules/@vue/language-server'
        --
        --   require('lspconfig').tsserver.setup({
        --     init_options = {
        --       plugins = {
        --         {
        --           name = '@vue/typescript-plugin',
        --           location = vue_typescript_plugin,
        --           languages = { 'vue' },
        --         },
        --       },
        --     },
        --     filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        --   })
        -- end,
        -- volar = function() require('lspconfig').volar.setup({}) end,

        -- None-Hybrid mode(similar to takeover mode) configuration (Requires @vue/language-server version ^2.0.7)
        tsserver = function()
          local vue_typescript_plugin = require('mason-registry').get_package('vue-language-server'):get_install_path()
            .. '/node_modules/@vue/language-server'
            .. '/node_modules/@vue/typescript-plugin'

          require('lspconfig').tsserver.setup({
            init_options = {
              plugins = {
                {
                  name = '@vue/typescript-plugin',
                  location = vue_typescript_plugin,
                  languages = { 'vue' },
                },
              },
            },
          })
        end,
        volar = function()
          require('lspconfig').volar.setup({
            init_options = {
              vue = {
                hybridMode = false,
              },
            },
          })
        end,

        lua_ls = function()
          -- helper functions
          -- local augroup_format = vim.api.nvim_create_augroup('Format', { clear = true })
          -- local enable_format_on_save = function(_, bufnr)
          --   vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
          --   vim.api.nvim_create_autocmd('BufWritePre', {
          --     group = augroup_format,
          --     buffer = bufnr,
          --     callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
          --   })
          -- end
          -- local lua_opts = lsp_zero.nvim_lua_ls()
          -- require('lspconfig').lua_ls.setup(lua_opts)
          local lua_opts = lsp_zero.nvim_lua_ls({
            -- Add format on save
            -- on_attach = function(client, bufnr)
            --   enable_format_on_save(client, bufnr)
            -- end,
            settings = {
              Lua = {
                completion = {
                  callSnippet = 'Replace',
                },
                -- diagnostics = {
                --   disable = { 'missing-fields' }, -- -- suppress 'Missing Required Fields' warnings
                -- },
                -- format = {
                --   enable = false, -- format with stylua (conform.nvim) instead of lua_ls (settings: .editorconfig)
                -- },
                -- workspace = {
                --   checkThirdParty = false,
                --   library = { -- aware runtime files
                --     [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                --     [vim.fn.stdpath('config') .. '/lua'] = true,
                --   },
                -- },
              },
            },
          })
          require('lspconfig').lua_ls.setup(lua_opts)
        end,
      },
    })

    require('mason-tool-installer').setup({
      ensure_installed = {
        'prettier', -- Code (Formatter)
        'stylua', -- Lua (Formatter)
        'shellcheck', -- Shell (Linter)
        'shfmt', -- Shell (Formatter)
        -- 'pylint', -- Python (Linter)
        -- 'flake8', -- Python (Linter)
        'ruff-lsp', -- Python (LSP/Linter/Formatter)
        -- 'ruff', -- Python (Linter/Formatter)
        -- 'black', -- Python (Formatter)
        -- 'isort', -- Python (Formatter: includes)
        'pint', -- PHP (Formatter)
        'eslint_d', -- JS/TS (Linter)
        'markdownlint', -- Markdown (Linter)
        'codespell', -- Code (Linter: words)
        -- { 'volar', version = '1.8.27' }, -- Vue.js FIX: (:MasonInstall volar@1.8.27)
      },
    })

    -- cmp mappings
    local cmp = require('cmp')
    local cmp_action = require('lsp-zero').cmp_action()
    local cmp_format = require('lsp-zero').cmp_format()

    -- load snippets
    require('luasnip.loaders.from_vscode').lazy_load()
    -- load user snippets
    require('luasnip.loaders.from_vscode').load({ paths = './snippets' })

    cmp.setup({
      window = {
        -- completion = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered({
          winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:None',
        }),
        -- documentation = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered({
          winhighlight = 'Normal:CmpDocumentation,FloatBorder:CmpDocumentationBorder,CursorLine:CursorLine,Search:None',
        }),
      },
      sources = { -- check with `:CmpStatus`
        { name = 'nvim_lsp' }, -- lsp server
        -- { name = 'nvim_lua' }, -- neovim lua API
        { name = 'lazydev' }, -- lazydev
        { name = 'luasnip' }, -- snippets
        { name = 'codeium', max_item_count = 5 }, -- codeium
        { name = 'buffer', keyword_length = 3, max_item_count = 10 }, -- buffer words
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

        -- Navigate between suggestions
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),

        -- Confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        -- Confirm completion with replace
        -- TODO: <S-CR> Don't work in Tmux => fallback <C+r>
        ['<S-CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        ['<C-r>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),

        -- Trigger completion menu
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

    -- -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    -- cmp.setup.cmdline({ '/', '?' }, {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = {
    --     { name = 'buffer' },
    --   },
    -- })
    --
    -- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    -- cmp.setup.cmdline(':', {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = cmp.config.sources({
    --     { name = 'path' },
    --   }, {
    --     { name = 'cmdline' },
    --   }),
    --   matching = { disallow_symbol_nonprefix_matching = false },
    -- })
    --
    -- for _, cmd_type in ipairs({ ':', '/', '?', '@' }) do
    --   cmp.setup.cmdline(cmd_type, {
    --     sources = {
    --       { name = 'cmdline_history' },
    --     },
    --   })
    -- end

    -- LSPKIND
    local lspkind = require('lspkind')
    cmp.setup({
      -- NOTE:The following line suppresses the warning 'Missing required fields'
      -- Source: https://github.com/LuaLS/lua-language-server/issues/2214
      -- Alternative add an global `disable = { 'missing-fields' }` to the lua_la config above
      --
      ---@diagnostic disable-next-line missing-fields
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text', -- show only symbol annotations
          menu = {
            nvim_lsp = '[lsp]',
            nvim_lua = '[lua]',
            luasnip = '[luasnip]',
            codeium = '[codeium]',
            buffer = '[buffer]',
            path = '[path]',
          },
          maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
        }),
      },
    })

    -- set diagnostic icons
    --
    -- TODO: In Neovim >= 0.10, you can configure diagnostic signs
    -- (also) with `vim.diagnostic.config()` instead of `vim.fn.sign_define`.
    --
    -- if vim.fn.has('nvim-0.10') == 1 then
    -- else
    -- end
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
