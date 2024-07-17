return {
  {
    -- TODO: clean up ~/.codeium/bin from old folders
    --       with language_server_macos_arm binaries
    --
    -- current version is now working, but the folder `~/.codeium/code_tracker/` musst be removed
    -- version = '1.8.37', -- pin to version 1.8.37 because of error (not working) in current version

    'Exafunction/codeium.vim',
    event = 'BufEnter',
    keys = {
      { '<Leader>tc', '<Cmd>CodeiumToggle<CR>', desc = 'Toggle Codeium' },
      {
        '<Tab>',
        function() return vim.fn['codeium#Accept']() end,
        mode = { 'i' },
        desc = 'Codeium: Accept',
        expr = true,
      },
      {
        '<C-f>', -- NOTE: Must `C`, don't works with `Ctrl`
        function() return vim.fn['codeium#CycleCompletions'](1) end,
        mode = { 'i' },
        desc = 'Codeium: Cycle completions',
        expr = true,
      },
      {
        '<Ctrl-x>', -- NOTE: Must `C`, don't works with `Ctrl`
        function() return vim.fn['codeium#Clear']() end,
        mode = { 'i' },
        desc = 'Codeium: Clear',
        expr = true,
      },
      -- {
      --   '<Leader>cc',
      --   function() return vim.fn['codeium#Chat']() end,
      --   mode = { 'n' },
      --   desc = 'Open Codeium chat',
      -- },
    },
    config = function()
      vim.g.codeium_disable_bindings = 1
      -- vim.g.codeium_tab_fallback = '<C-g>'
      -- vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true })
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
