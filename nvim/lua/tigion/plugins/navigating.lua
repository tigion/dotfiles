return {
  {
    -- This plugin adds a easy Neovim-Tmux navigation to Neovim.
    -- Link: https://github.com/alexghergh/nvim-tmux-navigation

    'alexghergh/nvim-tmux-navigation',
    event = 'VeryLazy',
  -- stylua: ignore
  keys = {
    -- no `mode = {}` defaults to 'n'
    { '<C-h>', '<Cmd>NvimTmuxNavigateLeft<CR>', desc = 'Go to the left window/pane' },
    { '<C-j>', '<Cmd>NvimTmuxNavigateDown<CR>', desc = 'Go to the down window/pane' },
    { '<C-k>', '<Cmd>NvimTmuxNavigateUp<CR>', desc = 'Go to the up window/pane' },
    { '<C-l>', '<Cmd>NvimTmuxNavigateRight<CR>', desc = 'Go to the right window/pane' },
    -- { '<C-\\>', '<Cmd>NvimTmuxNavigateLastActive<CR>', desc = 'Go to the previous window/pane' },
    -- { '<C-Space>', '<Cmd>NvimTmuxNavigateNext<CR>', desc = 'Go to the next window/pane' },
  },
    opts = {
      -- disable_when_zoomed = true,
    },
  },

  {
    -- This plugin lets you navigate your code with search labels,
    -- enhanced character motions, and Treesitter integration.
    --
    -- Replaces the default `s` and `S` substitute key mappings for
    -- characterwise and linewise deletions. (`:help s`)
    --
    -- Link: https://github.com/folke/flash.nvim

    'folke/flash.nvim',
    event = 'VeryLazy',
    enabled = true,
    ---@type Flash.Config
    opts = {
      labels = 'asdfghjklqwertzuiopyxcvbnm', -- Switched `y` and `z`.
      search = {
        multi_window = true,
      },
      label = {
        distance = true,
        -- min_pattern_length = 2,
      },
      modes = {
        -- Search with `/` or `?`.
        search = {
          enabled = false, -- Disabled, toggle manually with `<C-s>`.
        },
        -- Motions with `f`, `F`, `t`, `T`, `;` and `,`.
        char = {
          enabled = true,
          jump_labels = false,
        },
        treesitter = {
          -- labels = 'asdfghjklqwertzuiopyxcvbnm',
        },
      },
    },
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
      { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
      { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
      { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
      { '<C-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
      {
        '<CR>',
        mode = { 'n', 'x', 'o' },
        function() require('flash').treesitter({ actions = { ['<CR>'] = 'next', ['<BS>'] = 'prev' } }) end,
        desc = 'Treesitter incremental selection',
      },
    },
  },

  {
    -- This plugin adds a moving around your code in a syntax tree
    -- aware manner to Neovim.
    -- Link: https://github.com/aaronik/treewalker.nvim

    'aaronik/treewalker.nvim',
    keys = {
      { 'äj', '<Cmd>Treewalker Down<CR>', desc = 'Treewalker Down' },
      { 'äk', '<Cmd>Treewalker Up<CR>', desc = 'Treewalker Up' },
      { 'äh', '<Cmd>Treewalker Left<CR>', desc = 'Treewalker Left' },
      { 'äl', '<Cmd>Treewalker Right<CR>', desc = 'Treewalker Right' },
    },
    opts = {},
  },

  {
    -- This plugin adds a list of freqiently used files with hot keys to Neovim.
    -- Link: https://github.com/ThePrimeagen/harpoon

    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    keys = function()
      local keys = {
        {
          '<leader>H',
          function() require('harpoon'):list():add() end,
          desc = 'Harpoon File (add)',
        },
        {
          '<leader>h',
          function()
            local harpoon = require('harpoon')
            local toggle_opts = { -- HarpoonToggleOptions (ui.lua)
              border = 'rounded',
              title_pos = 'center',
            }
            harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts)
          end,
          desc = 'Harpoon Quick Menu',
        },
      }

      for i = 1, 9 do
        table.insert(keys, {
          '<leader>' .. i,
          function() require('harpoon'):list():select(i) end,
          desc = 'Harpoon to File ' .. i,
        })
      end
      return keys
    end,
    opts = {
      settings = {
        save_on_toggle = true,
      },
    },
  },
}
