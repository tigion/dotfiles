return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = { 'TroubleToggle', 'Trouble' },
  opts = { use_diagnostic_signs = true },
  keys = {
    { '<Leader>xx', '<cmd>TroubleToggle document_diagnostics<cr>', desc = 'Show document diagnostics' },
    { '<Leader>xX', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Show workspace diagnostics' },
    { '<Leader>xL', '<cmd>TroubleToggle loclist<cr>', desc = 'Show location list' },
    { '<Leader>xQ', '<cmd>TroubleToggle quickfix<cr>', desc = 'Show quickfix list' },
  },
}