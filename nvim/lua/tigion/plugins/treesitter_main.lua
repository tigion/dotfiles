return {
  {
    -- This plugin adds a Treesitter configuration and abstraction layer to Neovim.
    -- Link: https://github.com/nvim-treesitter/nvim-treesitter

    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup()

      -- Parsers to install
      local ensure_installed = {
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
        -- 'help',
        -- 'swift',
      }
      local installed = require('nvim-treesitter.config').installed_parsers()
      local not_installed = vim.tbl_filter(
        function(parser) return not vim.tbl_contains(installed, parser) end,
        ensure_installed
      )
      -- Calls `install()` only if there are missing parsers.
      if #not_installed > 0 then require('nvim-treesitter').install(not_installed) end

      -- TODO: Update or Remove if not needed
      --
      -- -- tsx: Update filetypes
      -- local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      -- parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }

      -- asciidoc: Adds a (experimental) parser for AsciiDoc.
      -- Source: https://github.com/nvim-treesitter/nvim-treesitter/blob/main/README.md#adding-parsers      --
      --
      -- NOTE: Install with: `:TSInstall asciidoc`
      --       Update with: `:TSUpdate`
      --
      -- NOTE: The `highlights.scm` must be copied manually to one of the following
      -- locations:
      -- - `~/.config/nvim/queries/asciidoc/`
      -- - `~/.local/share/nvim/site/queries/asciidoc/`
      --
      -- WARN: Uninstall with `:TSUninstall asciidoc`
      -- This removes only in `~/.local/share/nvim/site/parser` and
      -- not in `parser-info` and `queries`
      --
      vim.api.nvim_create_autocmd('User', {
        pattern = 'TSUpdate',
        callback = function()
          require('nvim-treesitter.parsers').asciidoc = {
            ---@diagnostic disable-next-line missing-fields
            install_info = {
              url = 'https://github.com/tigion/tree-sitter-asciidoc', -- git repo
              -- path = '~/projects/neovim/tree-sitter-asciidoc', -- local path
              revision = '2535b07174b9b00aadbe4c775c96254b9e40c30d', -- commit hash for revision to check out; HEAD if missing
            },
            -- WARN: `tier = 2` is important for custom parsers
            -- `norm_languages()` in config.lua checks vor `tier < 4`
            -- see: https://github.com/nvim-treesitter/nvim-treesitter/blob/0140c29b31d56be040697176ae809ba0c709da02/lua/nvim-treesitter/config.lua#L95
            -- tiers: 1: stable, 2: unstable, 3: unmaintained, 4: unsupported
            --        supported = tier < 4
            tier = 2,
          }
        end,
      })

      -- Activates highlights for `asciidoc` filetype or
      -- manually with `:lua vim.treesitter.start()`
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'asciidoc',
        callback = function()
          vim.treesitter.start()
          -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  -- {
  --   -- This plugin adds syntax aware text-objects to Neovim.
  --   -- Link: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  --
  --   'nvim-treesitter/nvim-treesitter-textobjects',
  --   branch = 'main',
  -- },
}
