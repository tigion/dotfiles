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
    { '<C-\\>', '<Cmd>NvimTmuxNavigateLastActive<CR>', desc = 'Go to the previous window/pane' },
    { '<C-Space>', '<Cmd>NvimTmuxNavigateNext<CR>', desc = 'Go to the next window/pane' },
  },
    opts = {
      -- disable_when_zoomed = true,
    },
  },

  {
    -- This plugin adds automatically highlighting and navigation
    -- other uses of the word under the cursor to Neovim.
    -- Link: https://github.com/RRethy/vim-illuminate

    'RRethy/vim-illuminate',
    event = 'VeryLazy',
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { 'lsp' },
      },
      filetypes_denylist = {
        'dirbuf',
        'dirvish',
        'fugitive',
        'nerdtree',
        'NvimTree',
      },
      min_count_to_highlight = 2,
    },
    config = function(_, opts)
      local illuminate = require('illuminate')

      illuminate.configure(opts)

      vim.keymap.set(
        'n',
        '++',
        function() illuminate.goto_next_reference(false) end,
        { desc = 'Next reference (Illuminate)' }
      )
      vim.keymap.set(
        'n',
        'üü',
        function() illuminate.goto_prev_reference(false) end,
        { desc = 'Prev reference (Illuminate)' }
      )
    end,
  },

  {
    -- This plugin adds a moving around your code in a syntax tree
    -- aware manner to Neovim.
    -- Link: https://github.com/aaronik/treewalker.nvim

    'aaronik/treewalker.nvim',
    keys = {
      { 'äj', '<CMD>Treewalker Down<CR>' },
      { 'äk', '<CMD>Treewalker Up<CR>' },
      { 'äh', '<CMD>Treewalker Left<CR>' },
      { 'äl', '<CMD>Treewalker Right<CR>' },
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
