return {
  'nvim-treesitter/nvim-treesitter', -- treesitter
  dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
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
        'css',
        'fish',
        'html',
        'json',
        'lua',
        'php',
        --'swift',
        'toml',
        'tsx',
        'yaml',
        'java',
        'javascript',
        'python',
        'markdown',
        'gitignore',
        'dockerfile',
        'vim',
        --'help',
        'c',
        'make',
      },
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