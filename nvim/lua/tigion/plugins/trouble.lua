return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = { 'TroubleToggle', 'Trouble' },
  opts = { use_diagnostic_signs = true },
  keys = {
    { '<Leader>xx', '<Cmd>TroubleToggle<CR>', desc = 'Trouble: Toggle trouble' },
    { '<Leader>xd', '<Cmd>TroubleToggle document_diagnostics<CR>', desc = 'Trouble: Toggle document diagnostics' },
    { '<Leader>xw', '<Cmd>TroubleToggle workspace_diagnostics<CR>', desc = 'Trouble: Toggleworkspace diagnostics' },
    { '<Leader>xL', '<Cmd>TroubleToggle loclist<CR>', desc = 'Trouble: Toggle location list' },
    { '<Leader>xQ', '<Cmd>TroubleToggle quickfix<CR>', desc = 'Trouble: Toggle quickfix list' },
  },
}
