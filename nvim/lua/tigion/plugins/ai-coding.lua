return {
  {
    -- This plugin lets you use integrates Copilot LSP's "Next Edit Suggestions"
    -- with a built-in terminal for any AI CLI.
    -- Link: https://github.com/folke/sidekick.nvim

    'folke/sidekick.nvim',
    opts = {
      signs = {
        enabled = true, -- enable signs by default
        icon = ' ',
      },
      nes = {
        enabled = true,
      },
      cli = {
        mux = {
          enabled = true,
          backend = 'tmux',
          create = 'split', -- "terminal"|"window"|"split"
        },
      },
    },
    keys = {
      {
        '<Tab>',
        function()
          -- If there is a next edit, jump to it, otherwise apply it if any.
          if not require('sidekick').nes_jump_or_apply() then
            return '<Tab>' -- Fallback to normal tab.
          end
        end,
        expr = true,
        desc = 'Sidekick Goto/Apply Next Edit Suggestion',
      },
      {
        '<Leader>aa',
        function() require('sidekick.cli').toggle() end,
        desc = 'Sidekick Toggle CLI',
      },
      {
        '<Leader>as',
        function() require('sidekick.cli').select() end,
        -- require("sidekick.cli").select({ filter = { installed = true } })
        desc = 'Sidekick Select CLI',
      },
      {
        '<Leader>ap',
        function() require('sidekick.cli').prompt() end,
        desc = 'Sidekick Ask Prompt',
        mode = { 'n', 'v' },
      },
    },
  },
  {
    -- This plugin lets you use GitHub Copilot in Neovim.
    -- Used for code completion and suggestions.
    -- Link: https://github.com/zbirenbaum/copilot.lua

    'zbirenbaum/copilot.lua',
    enabled = true,
    event = 'InsertEnter',
    keys = {
      {
        '<Leader>tc',
        function()
          if require('copilot.client').is_disabled() then
            require('copilot.command').enable()
            vim.notify('Copilot enabled')
          else
            require('copilot.command').disable()
            vim.notify('Copilot disabled')
          end
        end,
        desc = 'Toggle Copilot',
      },
      {
        '<Tab>',
        function()
          if require('copilot.suggestion').is_visible() then
            require('copilot.suggestion').accept()
            return
          end
          return '<Tab>' -- Fallback to normal tab.
        end,
        mode = { 'i' },
        desc = 'Copilot: Accept',
        expr = true,
      },
    },
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        -- enabled = true,
        auto_trigger = true, -- Automatically show suggestions. If false, use keymap accept, next or prev to trigger suggestion.
        -- hide_during_completion = true,
        -- debounce = 75,
        -- trigger_on_accept = true,
        keymap = {
          -- accept = '<Tab>',
          -- accept = '<C-i>',
          accept = false,
          accept_word = '<C-f>',
          accept_line = false,
          next = '<C-g>', -- '<M-]>'
          prev = '<C-G>', -- '<M-[>'
          dismiss = '<C-e>',
        },
      },
      nes = {
        enabled = false,
      },
      filetypes = {
        ['markdown'] = true,
      },
    },
  },
  {
    -- This plugin lets you use Suppermaven in Neovim.
    -- Link: https://github.com/supermaven-inc/supermaven-nvim

    'supermaven-inc/supermaven-nvim',
    enabled = false,
    event = 'BufEnter',
    keys = {
      { '<Leader>ts', '<Cmd>SupermavenToggle<CR>', desc = 'Toggle Supermaven' },
    },
    opts = {
      keymaps = {
        accept_suggestion = '<Tab>',
        clear_suggestion = '<C-e>',
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
    -- This plugin lets you use Codeium in Neovim.
    -- Link: https://github.com/Exafunction/codeium.vim

    -- TODO: Codeium is now Windsurf. Rename links and names.
    --       - https://github.com/Exafunction/windsurf.vim
    --       - https://github.com/Exafunction/windsurf.nvim

    -- NOTE: clean up ~/.codeium/bin from old folders
    --       with language_server_macos_arm binaries

    -- NOTE: current version is now working, but the folder `~/.codeium/code_tracker/` musst be removed
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
        '<C-e>',
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

  -- {
  --   -- https://github.com/augmentcode/augment.vim
  --   -- https://docs.augmentcode.com/vim/setup-augment/install-vim-neovim
  --
  --   -- TODO: Needs to be tested.
  --
  --   -- 'augmentcode/augment.vim',
  -- },
}
