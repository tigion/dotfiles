return {
  'smjonas/inc-rename.nvim',
  event = 'VeryLazy',
  cmd = 'IncRename',
  keys = {
    {
      '<Leader>rn',
      function() return ':IncRename ' .. vim.fn.expand('<cword>') end,
      desc = 'LSP: Rename with all references (IncRename)',
      expr = true,
    },
  },
  opts = {
    -- input_buffer_type = 'dressing',
  },
  -- config = function(_, opts)
  --   require('inc_rename').setup(opts)
  --
  --   vim.keymap.set('n', '<Leader>rm', function()
  --     return ':IncRename ' .. vim.fn.expand('<cword>')
  --   end, { expr = true, desc = 'LSP: Rename with all references' })
  -- end,
}
