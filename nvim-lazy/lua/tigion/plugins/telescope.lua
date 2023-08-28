return {
  -- telescope
  {
    'nvim-telescope/telescope.nvim', -- telescope
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',                   -- file browser
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }, -- fuzzy find
    },
    config = function()
      local status, telescope = pcall(require, 'telescope')
      if not status then return end
      local actions = require 'telescope.actions'
      local builtin = require 'telescope.builtin'

      local function telescope_buffer_dir() return vim.fn.expand '%:p:h' end

      local fb_actions = require 'telescope'.extensions.file_browser.actions

      telescope.setup {
        defaults = {
          mappings = {
            n = {
              ['q'] = actions.close,
            },
          },
          file_ignore_patterns = { '%.git/' }, -- ignore .git/ folders
        },
        pickers = {
          find_files = {
            hidden = true, -- find also hidden files
          },
          live_grep = {
            --only_sort_text = true,
            additional_args = function() return { '--hidden' } end, -- find also hidden files
          },
        },
        extensions = {
          file_browser = {
            theme = 'dropdown',
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            hidden = true, -- find also hidden files
            mappings = {
              -- your custom insert mode mappings
              ['i'] = {
                ['<C-w>'] = function() vim.cmd 'normal vbd' end,
              },
              ['n'] = {
                -- your custom normal mode mappings
                ['N'] = fb_actions.create,
                ['h'] = fb_actions.goto_parent_dir,
                ['/'] = function() vim.cmd 'startinsert' end,
              },
            },
          },
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = 'smart_case',       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
      }

      telescope.load_extension 'file_browser'
      telescope.load_extension 'fzf'

      vim.keymap.set('n', 'öf', function() builtin.find_files() end)
      vim.keymap.set('n', 'ög', function() builtin.live_grep() end)
      vim.keymap.set('n', 'öb', function() builtin.buffers() end)
      vim.keymap.set('n', 'öh', function() builtin.help_tags() end)
      vim.keymap.set('n', 'öö', function() builtin.resume() end)
      vim.keymap.set('n', 'öd', function() builtin.diagnostics() end)
      vim.keymap.set('n', 'sf', function()
        telescope.extensions.file_browser.file_browser {
          path = '%:p:h',
          cwd = telescope_buffer_dir(),
          respect_gitignore = false,
          hidden = true,
          grouped = true,
          previewer = false, -- deactivate preview
          initial_mode = 'normal',
          layout_config = {
            height = 40,
          },
        }
      end)
    end,
  },

  -- telescope extensions
  -- {
  --   'nvim-telescope/telescope-file-browser.nvim', -- file browser
  --   dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  -- },
  -- {
  --   'nvim-telescope/telescope-fzf-native.nvim', -- fuzzy find
  --   build = 'make',
  --   dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  -- },
}