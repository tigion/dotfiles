return {
  'nvim-treesitter/nvim-treesitter', -- treesitter
  build = ':TSUpdate',
  config = function()
    local status, ts = pcall(require, 'nvim-treesitter.configs')
    if not status then return end

    -- NOTE:The following line suppresses the warning 'Missing required fields'
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
  end,
}
