return {
  -- telescope
  {
    'nvim-telescope/telescope.nvim', -- telescope
    branch = '0.1.x',
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
          path_display = { 'truncate' },
          mappings = {
            n = {
              ['q'] = actions.close,
            },
            i = {
              ['<esc>'] = actions.close,
              ['<C-k>'] = actions.move_selection_previous, -- move to prev result
              ['<C-j>'] = actions.move_selection_next,     -- move to next result
              ['<tab>'] = actions.toggle_selection,
              ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
              ['<C-h>'] = 'which_key', -- help
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
          -- oldfiles = {
          --   cwd_only = true, -- find in current path / project only
          -- },
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

      -- keymaps
      local keymap = vim.keymap

      keymap.set('n', 'öf', builtin.find_files, { desc = 'Telescope: find files' })
      -- keymap.set('n', 'ör', builtin.oldfiles, { desc = 'Telescope: find recent files' })
      keymap.set('n', 'ör', '<cmd>Telescope oldfiles cwd_only=true<CR>',
        { desc = 'Telescope: find recent files (cwd)' })
      keymap.set('n', 'ög', builtin.live_grep, { desc = 'Telescope: find string' })
      keymap.set('n', 'öc', builtin.grep_string, { desc = 'Telescope: find string under cursor' })
      keymap.set('n', 'öb', builtin.buffers, { desc = 'Telescope: find in buffers' })
      keymap.set('n', 'öh', builtin.help_tags, { desc = 'Telescope: find in help' })
      keymap.set('n', 'öd', builtin.diagnostics, { desc = 'Telescope: find in diagnostics' })
      keymap.set('n', 'öö', builtin.resume, { desc = 'Telescope: reopen last search' })

      keymap.set('n', 'sf', function()
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