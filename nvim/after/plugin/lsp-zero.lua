local status, lsp = pcall(require, 'lsp-zero')
if not status then return end

lsp.preset 'recommended'

-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
lsp.ensure_installed {
  'tsserver', -- TypeScript
  'eslint', -- JavaScript, TypeScript
  'sumneko_lua', -- Lua
  'cssls', -- CSS, SCSS, LESS
  'clangd', -- C, C++
  'bashls', -- Bash (LSP)
  --'shellcheck', -- Bash (Linter)
  'marksman', -- Markdown
  'pyright', -- Python
  'vimls', -- VimScript
  'yamlls', -- Yaml
  'html', -- HTML
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
lsp.configure('sumneko_lua', {
  -- Add format on save
  on_attach = function(client, bufnr) enable_format_on_save(client, bufnr) end,
  -- Fix Undefined global 'vim'
  settings = {
    Lua = {
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
  suggest_lsp_servers = false,
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
require('mason-tool-installer').setup {
  ensure_installed = {
    'shellcheck', -- Bash (Linter)
  },
}

local lspkind = require 'lspkind'
cmp.setup {
  formatting = {
    format = lspkind.cmp_format { with_text = true, maxwidth = 50 },
  },
}
