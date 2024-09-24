return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim', -- helper for mason to preinstall packages like 'shellsheck' which are not LSPs
    -- 'neovim/nvim-lspconfig',
  },
  opts = {},
  config = function(_, opts)
    require('mason').setup(opts)

    local mason_lspconfig = require('mason-lspconfig')
    local mason_tool_installer = require('mason-tool-installer')

    mason_lspconfig.setup({
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
        'ts_ls', -- JavaScript, TypeScript
        'typos_lsp', -- Typos (Code Spell Checker)
        'vimls', -- VimScript
        'volar', -- Vue.js
        'yamlls', -- Yaml
      },
      automatic_installation = true,
      -- handlers = {},
    })

    mason_tool_installer.setup({
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
        -- 'eslint_d', -- JS/TS (Linter)
        { 'eslint_d', version = '13.1.2' }, -- JS/TS (Linter) FIX: (:MasonInstall eslint_d@13.1.2) Pin to older version to support the old config style (not the new flat config)
        'markdownlint-cli2', -- Markdown (Linter)
        -- 'markdownlint', -- Markdown (Linter)
        -- 'codespell', -- Code (Linter: words) use typos_lsp instead
        -- { 'volar', version = '1.8.27' }, -- Vue.js FIX: (:MasonInstall volar@1.8.27)
      },
    })
  end,
}
