return {
  {
    'Exafunction/codeium.vim',
    -- TODO: clean up ~/.codeium/bin from old folders
    --       with language_server_macos_arm binaries
    --
    version = '1.8.37', -- FIX: pin to version 1.8.37 because of error (not working) in current version
    event = 'InsertEnter',
    config = function()
      -- vim.g.codeium_disable_bindings = 1
      -- vim.g.codeium_no_map_tab = false
      -- vim.g.codeium_tab_fallback = '<C-g>'
      -- vim.keymap.set('n', 'coe', ':CodeiumEnable<CR>', { silent = true, desc = 'Enable Codeium' })
      -- vim.keymap.set('n', 'cod', ':CodeiumDisable<CR>', { silent = true, desc = 'Disable Codeium' })
      vim.keymap.set('n', '<Leader>c', ':CodeiumToggle<CR>', { silent = true, desc = 'Toggle Codeium' })
      vim.keymap.set('i', '<Tab>', function() return vim.fn['codeium#Accept']() end, { expr = true })
      -- vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<C-f>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end,
  },
  -- {
  --   'Exafunction/codeium.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'hrsh7th/nvim-cmp',
  --   },
  --   config = function() require('codeium').setup({}) end,
  -- },
}
