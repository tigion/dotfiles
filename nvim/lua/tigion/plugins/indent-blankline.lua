return {
  'lukas-reineke/indent-blankline.nvim', -- highlight indention level
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = { 'nvim-tree/nvim-tree.lua' }, -- treesitter
  main = 'ibl',
  opts = {
    --[[
    Note:
    - scope != current idention level
    - default highlight groups: 'IblIndent', 'IblWhitespace', 'IblScope'
      - configured in theme.lua
    ]]
    indent = {
      char = '┊',
    },
    -- whitespace = {},
    scope = {
      show_start = false,
      show_end = false,
      include = {
        -- add some extra nodes for better current idention highlight
        node_type = {
          -- https://github.com/MunifTanjim/tree-sitter-lua/blob/main/src/node-types.json
          lua = { 'return_statement', 'table_constructor' },
          -- https://github.com/tree-sitter/tree-sitter-bash/blob/master/src/node-types.json
          bash = { 'if_statement', 'case-statement', 'for_statement', 'while_statement', 'function_definition' },
          -- https://github.com/tree-sitter/tree-sitter-python/blob/master/src/node-types.json
          python = { 'if_statement', 'match_statement', 'for_statement', 'while_statement', 'try_statement' },
        },
      },
    },
  },
}

