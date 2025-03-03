return {
  {
    -- This plugin adds a Treesitter configuration and abstraction layer to Neovim.
    -- Link: https://github.com/nvim-treesitter/nvim-treesitter

    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local status, ts = pcall(require, 'nvim-treesitter.configs')
      if not status then return end

      -- NOTE: The following line suppresses the warning 'Missing required fields'
      -- Source: https://github.com/LuaLS/lua-language-server/issues/2214
      -- Alternative add an global `disable = { 'missing-fields' }` to the lua_la config above
      --
      ---@diagnostic disable-next-line missing-fields
      ts.setup({
        highlight = {
          enable = true,
          disable = {},
        },
        indent = {
          enable = true,
          disable = {},
        },
        ensure_installed = {
          'bash',
          'c',
          'css',
          'dockerfile',
          'gitignore',
          'html',
          'htmldjango',
          'java',
          'javascript',
          'json',
          'lua',
          'luadoc',
          'make',
          'markdown',
          'markdown_inline',
          'php',
          'phpdoc',
          'python',
          'regex',
          'toml',
          'tsx',
          'vim',
          'vimdoc',
          'vue',
          'yaml',
          --'help',
          --'swift',
        },
        auto_install = true,
        -- for incremental selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<CR>',
            node_incremental = '<CR>',
            scope_incremental = false,
            node_decremental = '<BS>',
          },
        },
      })

      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }

      -- Adds a (experimental) parser for AsciiDoc.
      -- Source: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#adding-parsers
      -- `:TSInstallFromGrammar asciidoc`
      -- local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      parser_config.asciidoc = {
        install_info = {
          url = 'https://github.com/tigion/tree-sitter-asciidoc', -- local path or git repo
          files = { 'src/parser.c' },
          branch = 'main',
        },
      }
    end,
  },

  -- {
  --   -- This plugin adds syntax aware text-objects to Neovim.
  --   -- Link: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  --
  --   'nvim-treesitter/nvim-treesitter-textobjects',
  -- },
}
