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
    -- NOTE:
    -- - `:lua Snacks.dashboard.open()`
    -- - `:lua Snacks.dashboard.update()`
    -- - `:lua require("lazy.manage.checker").check()`
    --
    dashboard = {
      enabled = true,
      width = math.min(math.max(vim.o.columns - 10, 40), 60),
      preset = {
        keys = function()
          local enabled = vim.o.lines >= 30
          local settings_action = '<Cmd>cd ' .. vim.fn.stdpath('config') .. '<CR><Cmd>NvimTreeOpen<CR>'
          return {
            { icon = '󰈔 ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
            { icon = '󱔗 ', key = 'r', desc = 'Recent Files', action = ':Telescope oldfiles' },
            { icon = ' ', key = 'l', desc = 'Load Session', action = ':Session load' },
            { icon = '󰱼 ', key = 'f', desc = 'Find File', action = ':Telescope find_files' },
            { icon = '󰺮 ', key = 'g', desc = 'Find Text', action = ':Telescope live_grep' },
            { icon = '󱤇 ', key = 'h', desc = 'Find Help Tag', action = ':Telescope live_grep', enabled = enabled },
            { icon = ' ', key = 's', desc = 'Settings', action = settings_action, enabled = enabled },
            { icon = ' ', key = 'p', desc = 'Check Plugins', action = ':Lazy', enabled = enabled },
            { icon = ' ', key = 'c', desc = 'Check Health', action = ':checkhealth', enabled = enabled },
            { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          }
        end,
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
          local version = require('tigion.core.util').info.nvim_version()
          local plugin_stats = require('tigion.core.util').info.plugin_stats()
          local date = os.date('%d.%m.%Y')
          local updates = plugin_stats.updates > 0 and '  ' .. plugin_stats.updates .. '' or ''
          return {
            align = 'center',
            text = {
              { ' ', hl = 'footer' },
              { version, hl = 'NonText' },
              { '    ', hl = 'footer' },
              { tostring(plugin_stats.count), hl = 'NonText' },
              { updates, hl = 'special' },
              { '   󰛕 ', hl = 'footer' },
              { plugin_stats.startuptime .. ' ms', hl = 'NonText' },
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

    -- Auto-show LSP references and quickly navigate between them
    words = {
      enabled = true,
      -- modes = { 'n' },
    },

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
    -- notifier
    { '<Leader>tn', function() Snacks.notifier.show_history() end, desc = 'Toggle Notifier History' },
    -- words
    { '++', function() Snacks.words.jump(1) end, desc = 'Next Reference' },
    { 'üü', function() Snacks.words.jump(-1) end, desc = 'Prev Reference' },
    -- zen
    { '<Leader>z', function() Snacks.zen.zen() end, desc = 'Toggle Zen Mode' },
    { '<Leader>Z', function() Snacks.zen.zoom() end, desc = 'Toggle Zen Zoom Mode' },
  },

  config = function(_, opts)
    local snacks = require('snacks')
    snacks.setup(opts)

    -- FIX: This is a workaround to show updates in the dashboard at startup.
    --      The dashboard is loaded before lazy.nvim has the information
    --      about updates. So it is updated again after 500 ms.
    vim.defer_fn(function()
      snacks.dashboard.update()
      -- vim.notify('Dashboard updated', vim.log.levels.DEBUG, { title = 'Snacks Setup' })
    end, 500)

    -- FIX: This is a workaround to update the dashboard
    --      every time when lazy.nvim checks for updates.
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyCheck',
      callback = function(ev)
        if vim.bo[ev.buf].filetype == 'snacks_dashboard' then
          -- vim.notify('Lazy.nvim checked for updates', vim.log.levels.DEBUG, { title = 'Snacks Autocmd' })
          snacks.dashboard.update()
          -- vim.notify('Dashboard updated', vim.log.levels.DEBUG, { title = 'Snacks Autocmd' })
        end
      end,
    })
  end,
}
