return {
  {
    'supermaven-inc/supermaven-nvim',
    event = 'BufEnter',
    keys = {
      { '<Leader>ts', '<Cmd>SupermavenToggle<CR>', desc = 'Toggle Supermaven' },
    },
    opts = {
      keymaps = {
        accept_suggestion = '<Tab>',
        clear_suggestion = '<C-x>',
        accept_word = '<C-f>',
      },
      -- ignore_filetypes = { cpp = true }, -- or { "cpp", }
      -- color = {
      --   -- suggestion_color = '#ffffff',
      --   -- cterm = 244,
      --   -- suggestion_color = vim.api.nvim_get_hl(0, { name = 'NonText' }).fg,
      --   -- cterm = vim.api.nvim_get_hl(0, { name = 'NonText' }).cterm,
      -- },
      -- log_level = 'off', -- info, set to "off" to disable logging completely
    },
    config = function(_, opts)
      require('supermaven-nvim').setup(opts)
      local api = require('supermaven-nvim.api')

      local in_git_repo = require('tigion.core.util').info.in_git_repo

      -- stop supermaven at start if not in a git repo and it is running
      -- because it will start automatically through setup()
      if not in_git_repo() and api.is_running() then api.stop() end

      -- vim.keymap.set('n', '<Leader>ts', function() api.toggle() end, { desc = 'Toggle Supermaven' })

      -- vim.keymap.set('n', '<Leader>ts', function()
      --   -- toggle global variable for stop condition
      --   -- first toggle sets the none existing variable to true
      --   vim.g.supermaven_enable = not vim.g.supermaven_enable
      --   -- stop or start supermaven
      --   if vim.g.supermaven_enable then
      --     if not api.is_running() then api.start() end
      --   else
      --     -- api.stop()
      --     if api.is_running() then api.stop() end
      --   end
      -- end, { desc = 'Toggle Supermaven' })
    end,
  },

  {
    -- NOTE: clean up ~/.codeium/bin from old folders
    --       with language_server_macos_arm binaries
    --
    -- current version is now working, but the folder `~/.codeium/code_tracker/` musst be removed
    -- version = '1.8.37', -- pin to version 1.8.37 because of error (not working) in current version

    'Exafunction/codeium.vim',
    enabled = false,
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
        '<C-f>',
        function() return vim.fn['codeium#CycleCompletions'](1) end,
        mode = { 'i' },
        desc = 'Codeium: Cycle completions',
        expr = true,
      },
      {
        '<C-x>',
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
