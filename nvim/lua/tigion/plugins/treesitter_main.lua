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
      local installed = require('nvim-treesitter.config').get_installed('parsers')
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
          ---@diagnostic disable-next-line missing-fields
          require('nvim-treesitter.parsers').asciidoc = {
            install_info = {
              url = 'https://github.com/tigion/tree-sitter-asciidoc', -- git repo
              -- path = '~/projects/neovim/tree-sitter-asciidoc', -- local path
              revision = '2535b07174b9b00aadbe4c775c96254b9e40c30d', -- commit hash for revision to check out; HEAD if missing
            },
          }
        end,
      })

      -- Activates highlights for `asciidoc` filetype or
      -- manually with `:lua vim.treesitter.start()`
      -- see': :h vi,.treesitter.start()
      -- see': :h vi,.treesitter.language.add()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'asciidoc',
        callback = function(args)
          if vim.treesitter.language.add('asciidoc') then
            vim.treesitter.start(args.buf, 'asciidoc')
            vim.bo[args.buf].syntax = 'on' -- Only for currently in tree-sitter-asciidoc unsupported inline syntax.
            -- vim.bo[args.buf].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            -- vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
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
