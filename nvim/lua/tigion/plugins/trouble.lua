return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = { 'TroubleToggle', 'Trouble' },
  opts = { use_diagnostic_signs = true },
  keys = {
    { '<Leader>xx', '<Cmd>TroubleToggle<CR>', desc = 'Toggle trouble' },
    { '<Leader>xd', '<Cmd>TroubleToggle document_diagnostics<CR>', desc = 'Show document diagnostics' },
    { '<Leader>xw', '<Cmd>TroubleToggle workspace_diagnostics<CR>', desc = 'Show workspace diagnostics' },
    { '<Leader>xl', '<Cmd>TroubleToggle loclist<CR>', desc = 'Show location list' },
    { '<Leader>xq', '<Cmd>TroubleToggle quickfix<CR>', desc = 'Show quickfix list' },
  },
}
