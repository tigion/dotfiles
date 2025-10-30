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

      local keymap = vim.keymap
      local icon_snacks = require('tigion.core.icons').snacks
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
          -- keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- calling twice jumps into hover message (default in neovim)
          -- keymap.set('i', '<C-k>', vim.lsp.buf.hover, opts)
          opts.desc = 'LSP: Show signature help'
          keymap.set('n', 'gK', vim.lsp.buf.signature_help, opts)
          keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)

          opts.desc = 'LSP: Toggle inlay hints'
          keymap.set(
            'n',
            '<Leader>ti',
            function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
            opts
          )

          opts.desc = 'LSP: ' .. icon_snacks .. ' Show document symbols'
          keymap.set('n', 'gs', function() Snacks.picker.lsp_symbols({ tree = false }) end, opts)
          -- opts.desc = 'LSP: ' .. icon_telescope .. ' Show document symbols'
          -- keymap.set('n', 'gs', '<Cmd>Telescope lsp_document_symbols<CR>', opts)
          -- keymap.set('n', '<Leader>gs', vim.lsp.buf.document_symbol, opts)

          opts.desc = 'LSP: ' .. icon_snacks .. ' Show workspace symbols'
          keymap.set('n', 'gss', function() Snacks.picker.lsp_workspace_symbols({ tree = false }) end, opts)
          -- opts.desc = 'LSP: ' .. icon_telescope .. ' Show workspace symbols'
          -- keymap.set('n', 'gss', '<Cmd>Telescope lsp_workspace_symbols<CR>', opts)
          -- Telescope lsp_workspace_symbols / lsp_dynamic_workspace_symbols
          -- keymap.set('n', '<Leader>gss', vim.lsp.buf.workspace_symbol, opts)

          opts.desc = 'LSP: ' .. icon_snacks .. ' Show references'
          keymap.set('n', 'gr', function() Snacks.picker.lsp_references() end, opts)
          -- opts.desc = 'LSP: ' .. icon_telescope .. ' Show references'
          -- keymap.set('n', 'gr', '<Cmd>Telescope lsp_references<CR>', opts)
          -- keymap.set('n', '<Leader>vrr', vim.lsp.buf.references, opts)

          opts.desc = 'LSP: ' .. icon_snacks .. ' Go to definition(s)'
          keymap.set('n', 'gd', function() Snacks.picker.lsp_definitions() end, opts)
          -- opts.desc = 'LSP: ' .. icon_telescope .. ' Go to definition(s)'
          -- keymap.set('n', 'gd', '<Cmd>Telescope lsp_definitions<CR>', opts)
          --keymap.set('n', 'gd', vim.lsp.buf.definition, opts) -- jumps to the definition

          opts.desc = 'LSP: Go to declaration'
          keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

          opts.desc = 'LSP: ' .. icon_snacks .. ' Go to type definition(s)'
          keymap.set('n', 'gdt', function() Snacks.picker.lsp_type_definitions() end, opts)
          -- opts.desc = 'LSP: ' .. icon_telescope .. ' Go to type definition(s)'
          -- keymap.set('n', 'gdt', '<Cmd>Telescope lsp_type_definitions<CR>', opts)
          -- keymap.set('n', 'gdt', vim.lsp.buf.type_definition, opts)

          opts.desc = 'LSP: ' .. icon_snacks .. ' Go to implementation(s)'
          keymap.set('n', 'gI', function() Snacks.picker.lsp_implementations() end, opts)
          -- opts.desc = 'LSP: ' .. icon_telescope .. ' Go to implementation(s)'
          -- keymap.set('n', 'gI', '<Cmd>Telescope lsp_implementations<CR>', opts)
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
      if vim.fn.has('nvim-0.11') == 1 then
        local hover = vim.lsp.buf.hover
        local signature = vim.lsp.buf.signature_help
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.lsp.buf.hover = function() return hover({ border = border }) end
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.lsp.buf.signature_help = function() return signature({ border = border }) end
      else
        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
          border = border,
        })
        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
          border = border,
        })
      end

      -- Add the same capabilities to ALL server configurations.
      -- Refer to :h vim.lsp.config() for more information.
      vim.lsp.config('*', {
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      })
    end,
  },
}
