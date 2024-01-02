return {
  'Exafunction/codeium.vim',
  event = 'InsertEnter',
  config = function()
    vim.keymap.set('n', 'coe', ':CodeiumEnable<CR>', { silent = true, desc = 'Enable Codeium' })
    vim.keymap.set('n', 'cod', ':CodeiumDisable<CR>', { silent = true, desc = 'Disable Codeium' })
    vim.keymap.set('n', 'cot', ':CodeiumToggle<CR>', { silent = true, desc = 'Toggle Codeium' })
    vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true })
    vim.keymap.set('i', '<C-i>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
    vim.keymap.set('i', '<C-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
    vim.keymap.set('i', '<C-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
    vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
  end,
}