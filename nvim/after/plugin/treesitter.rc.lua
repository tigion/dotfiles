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
    'swift',
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
    'help',
    'c',
    'make',
  },
  autotag = {
    enable = true,
  },
}

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }
