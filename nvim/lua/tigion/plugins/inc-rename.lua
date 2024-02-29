return {
  'smjonas/inc-rename.nvim',
  event = 'VeryLazy',
  cmd = 'IncRename',
  opts = {
    input_buffer_type = 'dressing',
  },
  -- keys = {
  --   {
  --     '<Leader>rn',
  --     function()
  --       return ':IncRename ' .. vim.fn.expand('<cword>')
  --     end,
  --     mode = { 'n' },
  --     desc = '[r]e[n]ame',
  --     expr = true,
  --   },
  -- },
  config = true,
  -- config = function(_, opts)
  --   require('inc_rename').setup(opts)
  --
  --   vim.keymap.set('n', '<Leader>rm', function()
  --     return ':IncRename ' .. vim.fn.expand('<cword>')
  --   end, { expr = true })
  -- end,
}

