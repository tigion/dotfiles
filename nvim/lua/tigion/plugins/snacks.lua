return {
  -- This plugin adds a collection of small QoL plugins to Neovim.
  -- Link: https://github.com/folke/snacks.nvim

  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,

  ---@module 'snacks'
  ---@type snacks.Config
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    -- Deal with big files
    bigfile = { enabled = true },

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
          local enabled = vim.o.lines >= 21
          return {
            { icon = '󰈔 ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
            { icon = '󱔗 ', key = 'r', desc = 'Recent Files', action = ':Telescope oldfiles' },
            {
              icon = ' ',
              key = 'l',
              desc = 'Load Session',
              action = ':Session load',
              enabled = require('sessions').exists(),
            },
            { icon = '󰱼 ', key = 'f', desc = 'Find File', action = ':Telescope find_files' },
            { icon = '󰺮 ', key = 'g', desc = 'Find Text', action = ':Telescope live_grep' },
            { icon = '󱤇 ', key = 'h', desc = 'Find Help Tag', action = ':Telescope help_tags', enabled = enabled },
            {
              icon = ' ',
              key = 's',
              desc = 'Settings',
              action = '<Cmd>cd ' .. vim.fn.stdpath('config') .. '<CR><Cmd>NvimTreeOpen<CR>',
              enabled = enabled,
            },
            { icon = ' ', key = 'p', desc = 'Check Plugins', action = ':Lazy', enabled = enabled },
            { icon = ' ', key = 'c', desc = 'Check Health', action = ':checkhealth', enabled = enabled },
            { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          }
        end,
        header = table.concat({
          [[   █  █   ]],
          [[   █ ██   ]],
          [[   ████   ]],
          [[   ██ ███   ]],
          [[   █  █   ]],
          [[             ]],
          [[ n e o v i m ]],
        }, '\n'),
      },
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        -- Prints some information about Neovim, the plugins and the date.
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
            padding = 1,
          }
        end,
        -- Greets the user depending on the time of day.
        function()
          -- Source: https://github.com/echasnovski/mini.nvim/blob/main/lua/mini/starter.lua
          -- [02:00, 10:00)(8h) - morning, [10:00, 18:00)(8h) - day, [18:00, 02:00)(8h) - evening
          local hour = tonumber(vim.fn.strftime('%H'))
          local part_id = math.floor((hour + 6) / 8) + 1
          local day_part = ({ 'evening', 'morning', 'afternoon', 'evening' })[part_id]
          local username = vim.loop.os_getenv('USER_ALIAS_NAME') or vim.loop.os_get_passwd()['username'] or 'user'
          return {
            align = 'center',
            text = { ('“Good %s, %s”'):format(day_part, username), hl = 'NonText' },
          }
        end,
      },
      config = function(opts, _)
        -- Change dashboard header depending on the height of the screen.
        if vim.o.lines < 37 then opts.sections[2].gap = 0 end
        if vim.o.lines < 28 then opts.preset.header = 'N E O V I M' end
      end,
    },

    -- A file explorer (picker in disguise)
    -- explorer = {
    --   enabled = true,
    -- },

    -- Image viewer using Kitty Graphics Protocol
    image = {
      doc = {
        inline = false, -- render the image inline in the buffer (takes precedence over `opts.float` on supported terminals)
        float = true, -- render the image in a floating window
        max_width = 40,
        max_height = 30,
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

    -- A modern fuzzy-finder. (Like Telescope)
    -- picker: separate config -> snacks.picker.lua

    -- Pretty `vim.notify`
    notifier = {
      enabled = true,
      margin = { top = 0, right = 1, bottom = 2 },
      top_down = false,
    },

    -- Scratch buffers with a persistent file
    scratch = {},

    -- Smooth scrolling for Neovim
    scroll = { enabled = true },

    ---@type table<string, snacks.win.Config>
    styles = {
      snacks_image = {
        relative = 'win',
        border = 'rounded',
        focusable = false,
        backdrop = false,
        row = 1,
        col = -2,
      },
    },

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
    -- explorer
    -- { '<Leader>E', function() Snacks.explorer() end, desc = 'Toggle File Explorer' },

    -- notifier
    { '<Leader>tn', function() Snacks.notifier.show_history() end, desc = 'Toggle Notifier History' },

    -- scratch
    { '<leader>.', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' },
    -- { '<leader>S', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },

    -- words
    { '++', function() Snacks.words.jump(1) end, desc = 'Next Reference' },
    { 'üü', function() Snacks.words.jump(-1) end, desc = 'Prev Reference' },

    -- zen
    { '<Leader>z', function() Snacks.zen.zen() end, desc = 'Toggle Zen Mode' },
    { '<Leader>Z', function() Snacks.zen.zoom() end, desc = 'Toggle Zen Zoom Mode' },
  },

  config = function(_, opts)
    local snacks = require('snacks')

    -- Change dashboard content depending on the height of the screen.
    -- if vim.o.lines < 37 then opts.dashboard.sections[2].gap = 0 end
    -- if vim.o.lines < 28 then opts.dashboard.preset.header = 'N E O V I M' end

    snacks.setup(opts)

    -- Workarounds

    -- FIX: This is a workaround to show updates in the dashboard at startup.
    --      The dashboard is loaded before lazy.nvim has the information
    --      about updates. So it is updated again after a short time.
    vim.defer_fn(function()
      snacks.dashboard.update()
      -- vim.notify('Dashboard updated', vim.log.levels.DEBUG, { title = 'Snacks Setup' })
    end, 1000)

    -- Autocommands

    -- Dashboard
    -- Updates an existing dashboard every time when lazy.nvim checks or updates plugins.
    vim.api.nvim_create_autocmd('User', {
      pattern = { 'LazyCheck', 'LazyUpdate' },
      callback = function()
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_get_option_value('filetype', { buf = bufnr }) == 'snacks_dashboard' then
            snacks.dashboard.update()
          end
        end
      end,
    })

    -- Notifier
    -- LSP Progress - Advanced
    -- https://github.com/folke/snacks.nvim/blob/main/docs/notifier.md#-examples
    ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
    local progress = vim.defaulttable()
    vim.api.nvim_create_autocmd('LspProgress', {
      ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= 'table' then return end
        local p = progress[client.id]

        for i = 1, #p + 1 do
          if i == #p + 1 or p[i].token == ev.data.params.token then
            p[i] = {
              token = ev.data.params.token,
              msg = ('[%3d%%] %s%s'):format(
                value.kind == 'end' and 100 or value.percentage or 100,
                value.title or '',
                value.message and (' **%s**'):format(value.message) or ''
              ),
              done = value.kind == 'end',
            }
            break
          end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v) return table.insert(msg, v.msg) or not v.done end, p)

        local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
        vim.notify(table.concat(msg, '\n'), 'info', {
          id = 'lsp_progress',
          title = client.name,
          opts = function(notif)
            notif.icon = #progress[client.id] == 0 and ' '
              or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          end,
        })
      end,
    })
  end,
}
