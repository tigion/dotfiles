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
        'sql',
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
      -- NOTE: Install with:   `:TSInstall asciidoc`
      --       Update with:    `:TSUpdate`
      --       Uninstall with: `:TSUninstall asciidoc`
      --
      -- WARN: Uninstall with `:TSUninstall asciidoc`
      -- This removes only in `~/.local/share/nvim/site/parser` and `queries` but
      -- not in `parser-info`
      --
      vim.api.nvim_create_autocmd('User', {
        pattern = 'TSUpdate',
        callback = function()
          ---@diagnostic disable-next-line missing-fields
          require('nvim-treesitter.parsers').asciidoc = {
            ---@diagnostic disable-next-line missing-fields
            install_info = {
              url = 'https://github.com/tigion/tree-sitter-asciidoc', -- git repo
              -- path = '~/projects/neovim/tree-sitter-asciidoc', -- local path
              -- revision = '2535b07174b9b00aadbe4c775c96254b9e40c30d', -- commit hash for revision to check out; HEAD if missing
              queries = 'queries', -- directory with query files
            },
          }
        end,
      })

      -- Activates highlights for supported filetypes or
      -- manually with `:lua vim.treesitter.start()`
      -- - `:h vim.treesitter.start()`, `:h vim.treesitter.language.add()`
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf = args.buf
          local filetype = vim.api.nvim_get_option_value('filetype', { buf = buf })
          if filetype == '' then return end -- Stops if no filetype is detected.

          -- Checks if a parser is available for the filetype.
          if vim.treesitter.language.add(filetype) then
            -- Activates the parser for the current buffer.
            vim.treesitter.start(buf, filetype)
            -- Sets other options for the current buffer.
            if filetype == 'asciidoc' then
              vim.bo[buf].syntax = 'on' -- Only for currently in tree-sitter-asciidoc unsupported inline syntax.
            end
            -- vim.bo[buf].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            -- vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
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
