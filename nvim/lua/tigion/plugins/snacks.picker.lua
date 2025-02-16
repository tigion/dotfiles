return {
  -- This plugin adds a collection of small QoL plugins to Neovim.
  -- Link: https://github.com/folke/snacks.nvim

  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,

  ---@module "snacks"
  ---@type snacks.Config
  ---@diagnostic disable-next-line: missing-fields
  opts = {
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
  },

  -- Keymaps for the snacks plugin
  keys = {
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
  },
}
