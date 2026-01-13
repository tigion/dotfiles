return {
  {
    -- This plugin lets you use integrates Copilot LSP's "Next Edit Suggestions"
    -- with a built-in terminal for any AI CLI.
    -- Link: https://github.com/folke/sidekick.nvim

    'folke/sidekick.nvim',
    enabled = require('tigion.core.util').is_allowed_on_host(),
    opts = {
      nes = {
        enabled = true,
      },
      cli = {
        mux = {
          enabled = true,
          backend = 'tmux',
          create = 'split', -- "terminal"|"window"|"split"
          split = {
            vertical = true, -- vertical or horizontal split
            size = 80, -- size of the split (0-1 for percentage)
          },
        },
        -- prompts = {
        --   refactor = 'Refactor the following code:\n\n{this}',
        -- },
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
        -- Only useful to toggle sidekick in terminal mode.
        '<C-.>',
        function() require('sidekick.cli').toggle() end,
        desc = 'Sidekick Toggle',
        mode = { 'n', 't', 'i', 'x' },
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
      {
        '<Leader>tan',
        function() require('sidekick.nes').toggle() end,
        desc = 'Toggle Copilot NES',
      },
    },
  },

  {
    -- This plugin lets you use GitHub Copilot in Neovim.
    -- Used for code completion and suggestions.
    -- Link: https://github.com/zbirenbaum/copilot.lua

    'zbirenbaum/copilot.lua',
    enabled = require('tigion.core.util').is_allowed_on_host(),
    event = 'InsertEnter',
    keys = {
      {
        '<Leader>taa',
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
        keymap = {
          accept = false, -- Use custom keymap in keys section instead '<Tab>'.
          accept_word = '<C-f>',
          accept_line = '<C-F>',
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
      -- Use the copilot-language-server installed by mason.nvim instead the bundled one.
      -- server = {
      --   type = 'binary',
      --   custom_server_filepath = '~/.local/share/nvim/mason/bin/copilot-language-server',
      -- },
    },
  },
}
