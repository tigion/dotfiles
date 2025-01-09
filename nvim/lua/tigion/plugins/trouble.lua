return {
  'folke/trouble.nvim',
  dependencies = { 'echasnovski/mini.icons' },
  -- dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = { 'TroubleToggle', 'Trouble' },
  opts = { use_diagnostic_signs = true },
  keys = {
    -- v2: { '<Leader>xx', '<Cmd>TroubleToggle<CR>', desc = 'Toggle trouble' },
    -- v2: { '<Leader>xw', '<Cmd>TroubleToggle workspace_diagnostics<CR>', desc = 'Toggle workspace diagnostics' },
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Toggle workspace diagnostics' },
    -- v2: { '<Leader>xd', '<Cmd>TroubleToggle document_diagnostics<CR>', desc = 'Toggle document diagnostics' },
    { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Toggle document/buffer diagnostics' },

    -- new:
    { '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Toggle symbols sidebar (Trouble)' },

    -- new:
    {
      '<leader>cl',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'Toggle LSP Definitions / references / ... (Trouble)',
    },

    -- v2: { '<Leader>xL', '<Cmd>TroubleToggle loclist<CR>', desc = 'Toggle location list' },
    { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Toggle location list' },
    -- v2: { '<Leader>xQ', '<Cmd>TroubleToggle quickfix<CR>', desc = 'Toggle quickfix list' },
    { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Toggle quickfix list' },

    -- Alternative: use `üd`, `+d` for diagnostics
    -- TODO: https://github.com/folke/trouble.nvim/issues/577
    {
      'üt',
      function() require('trouble').prev({ skip_groups = true, jump = true }) end,
      desc = 'Prev item (Trouble)',
    },
    { '+t', function() require('trouble').next({ skip_groups = true, jump = true }) end, desc = 'Next item (Trouble)' },
  },
}
