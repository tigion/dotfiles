return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = { 'TroubleToggle', 'Trouble' },
  opts = { use_diagnostic_signs = true },
  keys = {
    { '<Leader>xx', '<Cmd>TroubleToggle<CR>', desc = 'Toggle trouble' },
    { '<Leader>xd', '<Cmd>TroubleToggle document_diagnostics<CR>', desc = 'Toggle document diagnostics' },
    { '<Leader>xw', '<Cmd>TroubleToggle workspace_diagnostics<CR>', desc = 'Toggle workspace diagnostics' },
    { '<Leader>xL', '<Cmd>TroubleToggle loclist<CR>', desc = 'Toggle location list' },
    { '<Leader>xQ', '<Cmd>TroubleToggle quickfix<CR>', desc = 'Toggle quickfix list' },
    {
      'üt',
      function() require('trouble').previous({ skip_groups = true, jump = true }) end,
      desc = 'Previous item (Trouble)',
    },
    { '+t', function() require('trouble').next({ skip_groups = true, jump = true }) end, desc = 'Next item (Trouble)' },
  },
}
