return {
  'RRethy/vim-illuminate',
  event = 'VeryLazy',
  opts = {
    delay = 200,
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = { 'lsp' },
    },
    filetypes_denylist = {
      'dirbuf',
      'dirvish',
      'fugitive',
      'nerdtree',
      'NvimTree',
    },
    min_count_to_highlight = 2,
  },
  config = function(_, opts)
    local illuminate = require('illuminate')

    illuminate.configure(opts)

    vim.keymap.set(
      'n',
      '++',
      function() illuminate.goto_next_reference(false) end,
      { desc = 'Next reference (Illuminate)' }
    )
    vim.keymap.set(
      'n',
      'üü',
      function() illuminate.goto_prev_reference(false) end,
      { desc = 'Previous reference (Illuminate)' }
    )
  end,
}
