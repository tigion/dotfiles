return {
  -- This plugin adds a collection of small QoL plugins to Neovim.
  -- Link: https://github.com/folke/snacks.nvim

  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,

  ---@module 'snacks'
  ---@type snacks.Config
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
            {
              icon = '󱔗 ',
              key = 'r',
              desc = 'Recent Files',
              action = function() Snacks.picker.recent({ filter = { cwd = true } }) end,
            },
            {
              icon = ' ',
              key = 'l',
              desc = 'Load Session',
              action = ':Session load',
              enabled = require('sessions').exists(),
            },
            { icon = '󰱼 ', key = 'f', desc = 'Find File', action = function() Snacks.picker.files() end },
            { icon = '󰺮 ', key = 'g', desc = 'Find Text', action = function() Snacks.picker.grep() end },
            {
              icon = '󱤇 ',
              key = 'h',
              desc = 'Find Help Tag',
              action = function() Snacks.picker.help() end,
              enabled = enabled,
            },
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
          -- Source: https://github.com/nvim-mini/mini.nvim/blob/main/lua/mini/starter.lua
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
      -- Config hook to customize options after they have been resolved.
      config = function(opts, _)
        -- Change dashboard header depending on the height of the screen.
        if vim.o.lines < 37 then opts.sections[2].gap = 0 end
        if vim.o.lines < 28 then opts.preset.header = 'N E O V I M' end

        local snacks = require('snacks')

        -- FIX: This is a workaround to show updates in the dashboard at startup.
        --      The dashboard is loaded before lazy.nvim has the information
        --      about updates. So it is updated again after a short time.
        vim.defer_fn(function()
          snacks.dashboard.update()
          -- vim.notify('Dashboard updated', vim.log.levels.DEBUG, { title = 'Snacks Setup' })
        end, 1000)

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
      end,
    },

    -- A file explorer (picker in disguise)
    -- explorer = {
    --   enabled = true,
    -- },

    -- GitHub CLI integration
    gh = {
      enabled = false,
    },

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
      -- Config hook to customize options after they have been resolved.
      config = function()
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
    },

    -- A modern fuzzy-finder. (Like Telescope)
    picker = {
      -- The default layout preset.
      layout = function()
        return vim.o.columns >= 120 and 'my_telescope'
          or vim.o.lines >= 25 and 'my_telescope_vertical'
          or 'my_telescope_vertical_no_preview'
      end,
      matcher = {
        frecency = true,
      },
      ui_select = true, -- Better `vim.ui.select` (Snacks.picker.select)
      previewers = {
        git = {
          native = true, -- Use my local git previewer (delta).
        },
      },
      sources = {
        files = { hidden = true }, -- Shows hidden files.
        grep = { hidden = true }, -- Shows hidden files.
        explorer = {
          hidden = true,
          -- layout = { auto_hide = { 'input' } },
        }, -- Shows hidden files.
        select = { layout = { preset = 'my_select' } },
      },
      layouts = {
        my_telescope = {
          -- A borderless layout with a vertical split with a preview on the right.
          -- - Based on the default `telescope` layout.
          -- - Replaces `rounded` with `solid` borders.
          reverse = true,
          layout = {
            box = 'horizontal',
            backdrop = false,
            width = 0.8,
            height = 0.9,
            border = 'none',
            {
              box = 'vertical',
              { win = 'list', title = ' Results ', title_pos = 'center', border = 'solid' },
              { win = 'input', height = 1, border = 'solid', title = '{title} {live} {flags}', title_pos = 'center' },
            },
            {
              win = 'preview',
              title = '{preview:Preview}',
              width = 0.45,
              border = 'solid',
              title_pos = 'center',
            },
          },
        },
        my_telescope_vertical = {
          -- A borderless layout with a vertical split with a preview on the top.
          -- - Based on the `my_telescope` layout.
          reverse = true,
          layout = {
            box = 'vertical',
            backdrop = false,
            width = 0.8,
            height = 0.9,
            border = 'none',
            {
              win = 'preview',
              title = '{preview:Preview}',
              height = 0.4,
              border = 'solid',
              title_pos = 'center',
            },
            { win = 'list', title = ' Results ', title_pos = 'center', border = 'solid' },
            { win = 'input', height = 1, border = 'solid', title = '{title} {live} {flags}', title_pos = 'center' },
          },
        },
        my_telescope_vertical_no_preview = {
          -- A borderless layout with a vertical split without a preview on.
          -- - Based on the `my_telescope_vertical` layout.
          reverse = true,
          layout = {
            box = 'vertical',
            backdrop = false,
            width = 0.8,
            height = 0.9,
            border = 'none',
            { win = 'list', title = ' Results ', title_pos = 'center', border = 'solid' },
            { win = 'input', height = 1, border = 'solid', title = '{title} {live} {flags}', title_pos = 'center' },
          },
        },
        my_select = {
          -- A borderless layout for the select picker.
          -- Initial height of the inner root box is item count + 2
          -- https://github.com/folke/snacks.nvim/blob/70afc4225ac8ae3e6c8af88d205b03991a173af3/lua/snacks/picker/select.lua#L37
          -- FIX: Workaround to simulate a input box with solid border:
          --      - in root box: (input + box) + list)
          --      +----------+
          --      |          | <- root box border top
          --      +--------++|
          --      | >      ||| <- input box no top or bottom border
          --      +--------+||
          --      |         || <- box border bottom
          --      +---------+|
          --      | 1.      || <- list box no border
          --      | 2.      ||
          --      +---------++
          layout = {
            backdrop = false,
            width = 0.5,
            min_width = 80,
            height = 0.4,
            min_height = 1,
            border = 'top',
            title = '{title}',
            box = 'vertical', -- root box
            {
              box = 'vertical',
              border = 'bottom', -- inner box top border = 1 line
              height = 1,
              { win = 'input', title = '{title}', height = 1, border = 'hpad' }, -- input = 1 line
            },
            { win = 'list', border = 'none' }, -- list = #items lines
          },
        },
      },
      win = {
        input = {
          keys = {
            ['<Esc>'] = { 'close', mode = { 'n', 'i' } }, -- Closes the picker on ESC instead of going to normal mode.
          },
        },
        preview = {
          wo = {
            foldcolumn = '0',
            number = false,
            relativenumber = false,
            signcolumn = 'no',
          },
        },
      },
      debug = {
        scores = false,
      },
    },

    -- Scope detection based on treesitter or indent
    scope = {},

    -- Scratch buffers with a persistent file
    scratch = {},

    -- Smooth scrolling for Neovim
    scroll = {
      enabled = true,
      -- Config hook to customize options after they have been resolved.
      config = function()
        -- FIX: This is a workaround to prevent blink.cmp from flickering with snacks.scroll (snacks.animation).
        --
        -- Turns snacks.animation off while the blink.cmp menu is open,
        -- turn it back on afterwards.
        vim.api.nvim_create_autocmd('User', {
          pattern = 'BlinkCmpMenuOpen',
          callback = function() vim.g.snacks_animate = false end,
        })
        vim.api.nvim_create_autocmd('User', {
          pattern = 'BlinkCmpMenuClose',
          callback = function() vim.g.snacks_animate = true end,
        })
      end,
    },

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

    -- picker
    -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#-sources
    -- :lua Snacks.picker.pickers()
    -- Files
    { 'öf', function() Snacks.picker.files() end, desc = 'Find files (cwd)' },
    {
      'ör',
      function() Snacks.picker.recent({ filter = { cwd = true } }) end,
      desc = 'Find recent files (cwd)',
    },
    -- Buffers
    { 'öb', function() Snacks.picker.buffers() end, desc = 'Find open buffers' },
    -- Strings
    { 'ög', function() Snacks.picker.lines() end, desc = 'Find string (buffer)' },
    { 'ögg', function() Snacks.picker.grep() end, desc = 'Find string (cwd)' },
    {
      'öw',
      function() Snacks.picker.grep_word() end,
      mode = { 'n', 'x' },
      desc = 'Find current word/selection (cwd)',
    },
    -- Help tags
    { 'öh', function() Snacks.picker.help() end, desc = 'Find help tags' },
    -- Diagnostics
    { 'öd', function() Snacks.picker.diagnostics_buffer() end, desc = 'Find diagnostics (buffer)' },
    { 'ödd', function() Snacks.picker.diagnostics() end, desc = 'Find diagnostics (buffers)' },
    -- Commands and command history
    { 'ö:', function() Snacks.picker.commands() end, desc = 'Find commands' },
    { 'ö::', function() Snacks.picker.command_history() end, desc = 'Find command history' },
    -- Search history
    { 'ö/', function() Snacks.picker.search_history() end, desc = 'Find search history' },
    -- Git
    { 'öc', function() Snacks.picker.git_log_file() end, desc = 'Find git commits (file)' },
    { 'öcc', function() Snacks.picker.git_log() end, desc = 'Find git commits' },
    -- Treesitter
    {
      'ös',
      -- function() Snacks.picker.treesitter({ tree = false }) end,
      function() Snacks.picker.treesitter({ tree = false, filter = { default = true } }) end,
      desc = 'Find Treesitter symbols',
    },
    {
      'öS',
      function() Snacks.picker.lsp_symbols({ tree = false }) end,
      -- function() Snacks.picker.lsp_symbols({ tree = false, filter = { default = true, lua = true } }) end,
      desc = 'Find LSP symbols',
    },
    {
      'öSS',
      function() Snacks.picker.lsp_workspace_symbols() end,
      desc = 'Find LSP symbols (cwd)',
    },
    -- Register
    { 'öR', function() Snacks.picker.registers() end, desc = 'Find registers' },
    -- Snacks.picker
    { 'öö', function() Snacks.picker.resume() end, desc = 'Reopen previous search' },
    { 'ööö', function() Snacks.picker.pickers() end, desc = 'Find picker sources' },

    -- scratch
    { '<leader>.', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' },
    -- { '<leader>S', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },

    -- words
    -- { 'üü', function() Snacks.words.jump(-1) end, desc = 'Prev Reference' },
    -- { '++', function() Snacks.words.jump(1) end, desc = 'Next Reference' },
    { '[[', function() Snacks.words.jump(-1) end, desc = 'Prev Reference' },
    { ']]', function() Snacks.words.jump(1) end, desc = 'Next Reference' },

    -- zen
    { '<Leader>z', function() Snacks.zen.zen() end, desc = 'Toggle Zen Mode' },
    { '<Leader>Z', function() Snacks.zen.zoom() end, desc = 'Toggle Zen Zoom Mode' },
  },

  -- config = function(_, opts)
  --   print('Setting up Snacks...')
  --   local snacks = require('snacks')
  --   snacks.setup(opts)
  --
  --   -- Autocommands
  --
  --   -- Notifier
  --   print('Snacks setup done.')
  -- end,
}
