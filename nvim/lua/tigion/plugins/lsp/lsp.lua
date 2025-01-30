return {
  {
    -- This plugin providing basic, default Nvim LSP client configurations
    -- for various LSP servers.
    -- Link: https://github.com/neovim/nvim-lspconfig

    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      -- { "antosha417/nvim-lsp-file-operations", config = true }, -- TODO: Check if it's needed
    },
    config = function()
      -- vim.opt.signcolumn = 'yes'

      local lspconfig = require('lspconfig')
      local mason_lspconfig = require('mason-lspconfig')

      local keymap = vim.keymap
      local icon_telescope = require('tigion.core.icons').telescope
      local icons_diagnostic = require('tigion.core.icons').diagnostic

      local border = 'rounded'

      -- Executes the callback function every time a
      -- language server is attached to a buffer.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('LspAttached', {}),
        -- group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(event)
          local opts = { buffer = event.buf, remap = false, silent = false }

          -- https://github.com/neovim/neovim/discussions/25711
          opts.desc = 'LSP: Show hover information'
          keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- calling twice jumps into hover message
          -- keymap.set('i', '<C-k>', vim.lsp.buf.hover, opts)
          opts.desc = 'LSP: Show signature help'
          keymap.set('n', 'gK', vim.lsp.buf.signature_help, opts) -- ? default in nvim v0.10
          keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)

          opts.desc = 'LSP: Toggle inlay hints'
          keymap.set(
            'n',
            '<Leader>ti',
            function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
            opts
          )

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
          opts.desc = 'Rename with references (lsp)'
          keymap.set('n', '<Leader>rN', vim.lsp.buf.rename, opts)

          -- Deactivated: See formatting.lua (conform.nvim)
          -- opts.desc = 'LSP: Format current buffer'
          -- keymap.set('n', '<Leader>f', vim.lsp.buf.format, opts)

          opts.desc = 'Show line diagnostics'
          keymap.set('n', '<Leader>d', vim.diagnostic.open_float, opts)
          -- Deactivated: See telescope.lua (telescope.nvim)
          -- opts.desc = icon_telescope .. ' Show diagnostics for buffer'
          -- keymap.set('n', '<Leader>dd', '<Cmd>Telescope diagnostics bufnr=0<CR>', opts)
          -- opts.desc = icon_telescope .. ' Show diagnostics for all buffers'
          -- keymap.set('n', '<Leader>da', '<Cmd>Telescope diagnostics<CR>', opts)

          -- Deactivated: See keymaps.lua
          -- opts.desc = 'Next diagnostic'
          -- keymap.set('n', '+d', vim.diagnostic.goto_next, opts)
          -- opts.desc = 'Prev diagnostic'
          -- keymap.set('n', 'üd', vim.diagnostic.goto_prev, opts)

          opts.desc = 'Restart LSP servers (buffer)'
          keymap.set('n', '<Leader>rs', ':LspRestart<CR>', opts)
        end,
      })

      -- Sets icons and styling for diagnostics
      vim.diagnostic.config({
        underline = true,
        virtual_text = { -- true
          prefix = icons_diagnostic.virtual_text_prefix,
        },
        signs = { -- true
          text = {
            [vim.diagnostic.severity.ERROR] = icons_diagnostic.signs.error,
            [vim.diagnostic.severity.WARN] = icons_diagnostic.signs.warn,
            [vim.diagnostic.severity.INFO] = icons_diagnostic.signs.info,
            [vim.diagnostic.severity.HINT] = icons_diagnostic.signs.hint,
          },
        },
        float = { -- true
          source = true,
          border = border,
        },
        update_in_insert = false,
        severity_sort = true,
      })

      -- Sets styling for hover and signature help
      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = border,
      })
      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = border,
      })

      -- used to enable autocompletion (assign to every lsp server config)
      -- nvim-cmp -> cmp-nvim-lsp:
      -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- blink.cmp:
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Sets up LSP servers installed via `mason.nvim`
      mason_lspconfig.setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,

        -- Dedicated handlers, which overrides default handlers for specific servers.

        ['basedpyright'] = function()
          lspconfig.basedpyright.setup({
            capabilities = capabilities,
            settings = {
              basedpyright = {
                analysis = {
                  typeCheckingMode = 'standard', -- Use 'standard' like pyright instead of the default 'recommended'.
                },
              },
            },
          })
        end,

        ['html'] = function()
          -- lspconfig['html'].setup({
          lspconfig.html.setup({
            capabilities = capabilities,
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

        ['lua_ls'] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                completion = {
                  callSnippet = 'Replace',
                },
                hint = {
                  enable = true, -- necessary
                },
              },
            },
          })
        end,

        ['ts_ls'] = function()
          local vue_typescript_plugin = require('mason-registry').get_package('vue-language-server'):get_install_path()
            .. '/node_modules/@vue/language-server'
            .. '/node_modules/@vue/typescript-plugin'

          lspconfig.ts_ls.setup({
            capabilities = capabilities,
            init_options = {
              plugins = {
                {
                  name = '@vue/typescript-plugin',
                  location = vue_typescript_plugin,
                  languages = { 'vue' },
                },
              },
            },
            settings = {
              typescript = {
                inlayHints = {
                  includeInlayParameterNameHints = 'all',
                  includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
              javascript = {
                inlayHints = {
                  includeInlayParameterNameHints = 'all',
                  includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
            },
          })
        end,
        ['volar'] = function()
          lspconfig.volar.setup({
            capabilities = capabilities,
            init_options = {
              vue = {
                hybridMode = false,
              },
            },
          })
        end,

        ['typos_lsp'] = function()
          lspconfig.typos_lsp.setup({
            capabilities = capabilities,
            init_options = {
              diagnosticSeverity = 'Info', -- Error, Warning, Info or Hint
            },
          })
        end,
      })
    end,
  },

  {
    -- This plugin adds an Extensible UI for Neovim notifications and
    -- LSP progress messages to Neovim.
    -- Link: https://github.com/j-hui/fidget.nvim

    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {
      progress = {
        display = {
          skip_history = false,
        },
      },
      notification = {
        window = {
          border = 'rounded',
        },
      },
    },
  },
}
