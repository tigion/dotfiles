return {
  -- This plugin adds a collection of small QoL plugins to Neovim.
  -- Link: https://github.com/folke/snacks.nvim

  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@module 'snacks'
  ---@type snacks.Config
  opts = {
    -- bigfile = { enabled = true },

    -- Beautiful declarative dashboards
    dashboard = {
      enabled = true,
      width = math.min(math.max(vim.fn.winwidth(0) - 10, 40), 60),
      preset = {
        keys = {
          { icon = '󰈔 ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = '󱔗 ', key = 'r', desc = 'Recent Files', action = ':Telescope oldfiles' },
          { icon = ' ', key = 'l', desc = 'Load Session', action = ':Session load' },
          { icon = '󰱼 ', key = 'f', desc = 'Find File', action = ':Telescope find_files' },
          { icon = '󰺮 ', key = 'g', desc = 'Find Text', action = ':Telescope live_grep' },
          { icon = '󱤇 ', key = 'h', desc = 'Find Help Tag', action = ':Telescope live_grep' },
          {
            icon = ' ',
            key = 's',
            desc = 'Settings',
            action = '<Cmd>cd ' .. vim.fn.stdpath('config') .. '<CR><Cmd>NvimTreeOpen<CR>',
          },
          { icon = ' ', key = 'p', desc = 'Check Plugins', action = ':Lazy' },
          { icon = ' ', key = 'c', desc = 'Check Health', action = ':checkhealth' },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
        -- header = {
        --   [[  _  _             _        ]],
        --   [[ | \| |___ _____ _(_)_ __   ]],
        --   [[ | .` / -_) _ \ V / | '  \  ]],
        --   [[ |_|\_\___\___/\_/|_|_|_|_| ]],
        -- },
        header = table.concat({
          [[  _  _             _        ]],
          [[ | \| |___ _____ _(_)_ __   ]],
          [[ | .` / -_) _ \ V / | '  \  ]],
          [[ |_|\_\___\___/\_/|_|_|_|_| ]],
        }, '\n'),
      },
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        ---Returns a custom footer text section.
        function()
          local nvim_version = require('tigion.core.util').info.nvim_version
          local plugin_stats = require('tigion.core.util').info.plugin_stats
          local version, date = nvim_version(), os.date('%d.%m.%Y')
          local count = plugin_stats().count
          local startuptime = plugin_stats().startuptime
          local updates = ''
          if plugin_stats().updates > 0 then updates = '  ' .. plugin_stats().updates .. '' end
          return {
            align = 'center',
            text = {
              { ' ', hl = 'footer' },
              { '' .. version, hl = 'NonText' },
              { '    ', hl = 'footer' },
              { '' .. count, hl = 'NonText' },
              { updates, hl = 'special' },
              { '   󰛕 ', hl = 'footer' },
              { startuptime .. ' ms', hl = 'NonText' },
              { '    ', hl = 'footer' },
              { date, hl = 'NonText' },
            },
          }
        end,
      },
    },

    -- Indent guides and scopes
    indent = {
      indent = { char = '┊' },
      animate = { enabled = false },
      scope = { char = '┊' },
    },

    -- Better `vim.ui.input`
    input = { enabled = true },

    -- Pretty `vim.notify`
    notifier = { enabled = true },

    -- Zen mode • distraction-free coding
    zen = {
      toggles = {
        dim = false,
        git_signs = true,
        mini_diff_signs = true,
        diagnostics = true,
        inlay_hints = false,
      },
      show = {
        statusline = true, -- can only be shown when using the global statusline
        tabline = false,
      },
      win = {
        backdrop = { transparent = false },
        -- width = 120,
      },
    },
  },

  -- Keymaps for the snacks plugin
  keys = {
    { '<Leader>tn', function() Snacks.notifier.show_history() end, desc = 'Toggle Notifier History' },
    { '<Leader>z', function() Snacks.zen.zen() end, desc = 'Toggle Zen Mode' },
    { '<Leader>Z', function() Snacks.zen.zoom() end, desc = 'Toggle Zen Zoom Mode' },
  },

  config = function(_, opts)
    local snacks = require('snacks')

    -- Reduces the size of the dashboard for small window heights.
    local win_height = vim.fn.winheight(0)
    local dashboard_height = 4 + 1 + 2 * #opts.dashboard.preset.keys + 1 + 1
    if win_height < dashboard_height + 3 then
      opts.dashboard.preset.header = 'Neovim'
      table.remove(opts.dashboard.preset.keys, #opts.dashboard.preset.keys - 1)
      table.remove(opts.dashboard.preset.keys, #opts.dashboard.preset.keys - 1)
      table.remove(opts.dashboard.preset.keys, #opts.dashboard.preset.keys - 1)
      table.remove(opts.dashboard.preset.keys, #opts.dashboard.preset.keys - 1)
    end

    snacks.setup(opts)
  end,
}
