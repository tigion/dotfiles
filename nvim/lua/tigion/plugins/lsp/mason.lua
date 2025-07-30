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
        'basedpyright', -- Python (LSP, better fork of pyright) -- Replaces `pyright`
        'bashls', -- Bash (LSP, bash-language-server)
        'biome', -- JavaScript, TypeScript (LSP, Linter, Formatter) -- TODO: Needs testing to replace eslint.
        'clangd', -- C, C++ (LSP)
        'cssls', -- CSS, SCSS, LESS (LSP, css-lsp)
        'eslint', -- JavaScript, TypeScript (LSP, eslint_lsp) -- Replaces `eslint_d`
        'html', -- HTML (LSP, html-lsp)
        'intelephense', -- PHP (LSP)
        'jdtls', -- Java (LSP)
        'jsonls', -- JSON (LSP, json-lsp)
        'lua_ls', -- Lua (LSP, lua-language-server)
        'marksman', -- Markdown (LSP)
        'phpactor', -- PHP (LSP)
        -- 'pyright', -- Python (LSP) -- Replaced by `basedpyright`
        'ruff', -- Python (LSP, Linter, Formatter)
        -- 'ts_ls', -- JavaScript, TypeScript (LSP, typescript-language-server) -- Replaced by `vtsls`
        'typos_lsp', -- * (LSP, typos-lsp, Code Spell Checker)
        'vimls', -- VimScript (LSP, vim-language-server)
        'vtsls', -- JavaScript, TypeScript, Vue via vue_ls -- Replaces `ts_ls`
        -- NOTE:
        -- - Since `vue_ls` v3.0 `vtsls` instead `ts_ls` is required to support JavaScript or TypeScript.
        -- - `volar` is renamed to `vue_ls` (vue-language-server)
        'vue_ls', -- Vue (LSP, vue-language-server)
        'yamlls', -- YAML (LSP, yaml-language-server)
      },
      automatic_installation = true,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        'markdownlint-cli2', -- Markdown (Linter, Formatter)
        'prettier', -- * (Formatter)
        'shellcheck', -- Bash (Linter)
        'shfmt', -- Bash, Mksh, Shell (Formatter)
        'stylua', -- Lua (Formatter)

        -- 'pylint', -- Python (Linter)
        -- 'flake8', -- Python (Linter)
        -- 'ruff-lsp', -- Python (LSP/Linter/Formatter) -- replaced by new ruff (06.11.2024)
        -- 'black', -- Python (Formatter)
        -- 'isort', -- Python (Formatter: includes)

        -- 'pint', -- PHP (Formatter) -- Use LSP fallback from intelephense -- Configure to also format embedded HTML

        -- 'eslint_d', -- JS/TS (Linter) -- Replaced by `eslint`
        -- { 'eslint_d', version = '13.1.2' }, -- JS/TS (Linter) -- (:MasonInstall eslint_d@13.1.2) Pin to older version to support the old config style (not the new flat config)

        -- 'markdownlint', -- Markdown (Linter)

        -- 'codespell', -- Code (Linter: words) use typos_lsp instead
        -- { 'volar', version = '1.8.27' }, -- Vue.js -- (:MasonInstall volar@1.8.27) Pin to older version.
        -- 'jsonlint', -- JSON (Linter)
      },
    })
  end,
}
