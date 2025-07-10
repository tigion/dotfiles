return {
  -- This plugin adds a color scheme to Neovim.
  -- Link: https://github.com/mason-org/mason.nvim

  'mason-org/mason.nvim',
  dependencies = {
    -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
    -- Link: https://github.com/mason-org/mason-lspconfig.nvim
    'mason-org/mason-lspconfig.nvim',
    -- Install or upgrade all of your third-party tools.
    -- Link: https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  opts = {},
  config = function(_, opts)
    require('mason').setup(opts)

    local mason_lspconfig = require('mason-lspconfig')
    local mason_tool_installer = require('mason-tool-installer')

    mason_lspconfig.setup({
      ensure_installed = {
        'bashls', -- Bash (LSP)
        'biome', -- JavaScript, TypeScript (LSP, Linter, Formatter) -- TODO: Needs testing to replace eslint.
        'clangd', -- C, C++
        'cssls', -- CSS, SCSS, LESS
        'eslint', -- JavaScript, TypeScript (replaces eslint_d)
        'html', -- HTML
        'intelephense', -- PHP
        'jdtls', -- Java
        'jsonls', -- JSON
        'lua_ls', -- Lua
        'marksman', -- Markdown
        'phpactor', -- PHP
        'basedpyright', -- Python (better fork of pyright)
        -- 'pyright', -- Python
        'ruff', -- Python (LSP/Linter/Formatter)
        'ts_ls', -- JavaScript, TypeScript
        'typos_lsp', -- Typos (Code Spell Checker)
        'vimls', -- VimScript
        'vtsls', -- Since v3.0.0, the Vue language server (vue_ls) requires `vtsls` to support TypeScript.
        'vue_ls', -- Vue.js (volar renamed to vue_ls (vue-language-server))
        'yamlls', -- Yaml
      },
      automatic_installation = true,
      -- handlers = {},

      -- FIX: Workaround for mason-lspconfig errors with
      --      the new `vue_ls` config in nvim-lspconfig.
      --
      -- - https://github.com/neovim/nvim-lspconfig/commit/85379d02d3bac8dc68129a4b81d7dbd00c8b0f77
      --
      -- Don't start with `vue_ls` config from mason-lspconfig,
      -- instead start directly with `vim.lsp.enable`.
      --
      -- <- fix start
      automatic_enable = { exclude = { 'vue_ls' } },
      vim.lsp.enable({ 'vue_ls' }),
      -- <- fix end
    })

    mason_tool_installer.setup({
      ensure_installed = {
        'prettier', -- Code (Formatter)
        'stylua', -- Lua (Formatter)
        'shellcheck', -- Shell (Linter)
        'shfmt', -- Shell (Formatter)
        -- 'pylint', -- Python (Linter)
        -- 'flake8', -- Python (Linter)
        -- 'ruff-lsp', -- Python (LSP/Linter/Formatter) -- replaced by new ruff (06.11.2024)
        -- 'black', -- Python (Formatter)
        -- 'isort', -- Python (Formatter: includes)
        -- 'pint', -- PHP (Formatter) -- Use LSP fallback from intelephense TODO: configure to also format embedded HTML
        -- 'eslint_d', -- JS/TS (Linter) -- replaced by eslint_lsp -- TODO: Needs testing with flat config and projects without own eslint.
        -- { 'eslint_d', version = '13.1.2' }, -- JS/TS (Linter) NOTE: (:MasonInstall eslint_d@13.1.2) Pin to older version to support the old config style (not the new flat config)
        'markdownlint-cli2', -- Markdown (Linter)
        -- 'markdownlint', -- Markdown (Linter)
        -- 'codespell', -- Code (Linter: words) use typos_lsp instead
        -- { 'volar', version = '1.8.27' }, -- Vue.js FIX: (:MasonInstall volar@1.8.27)
        -- 'jsonlint', -- JSON (Linter)
      },
    })
  end,
}
