return {
  'nvim-treesitter/nvim-treesitter', -- treesitter
  build = ':TSUpdate',
  config = function()
    local status, ts = pcall(require, 'nvim-treesitter.configs')
    if not status then return end

    ts.setup {
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
        'java',
        'javascript',
        'json',
        'lua',
        'make',
        'markdown',
        'php',
        'python',
        'toml',
        'tsx',
        'vim',
        'yaml',
        --'help',
        --'htmldjango',
        --'swift',
      },
      auto_install = true,
      -- for ts-autotag
      autotag = {
        enable = true,
      },
      -- for nvim-ts-context-commentstring
      context_commentstring = {
        enable = true,
      },
    }

    local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
    parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }
  end,
}