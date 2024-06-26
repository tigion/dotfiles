return {
  -- telescope
  {
    'nvim-telescope/telescope.nvim', -- telescope
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- 'nvim-telescope/telescope-file-browser.nvim', -- file browser
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }, -- fuzzy find
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      local builtin = require('telescope.builtin')

      -- local fb_actions = require('telescope').extensions.file_browser.actions
      -- local function telescope_buffer_dir() return vim.fn.expand('%:p:h') end

      telescope.setup({
        defaults = {
          path_display = { 'truncate' },
          -- path_display = { 'smart' },
          -- wrap_results = true,
          mappings = {
            n = {
              ['q'] = actions.close,
            },
            i = {
              ['<Esc>'] = actions.close,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-j>'] = actions.move_selection_next,
              -- ['<Tab>'] = actions.toggle_selection, -- toggle selection of an item (replace default behavior)
              -- ['<S-Tab>'] = actions.toggle_all, -- toggle selection of all items (replace default behavior)
              ['<C-r>'] = actions.toggle_all, -- toggle (reverse) selection of all items
              ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist, -- send smart (all or selected items) to quickfix list (replace default behavior)
              ['<C-h>'] = 'which_key', -- help
              -- ['<C-h>'] = actions.preview_scrolling_left,
              -- ['<C-l>'] = actions.preview_scrolling_right,
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
          -- file_browser = {
          --   theme = 'dropdown',
          --   -- disables netrw and use telescope-file-browser in its place
          --   hijack_netrw = true,
          --   hidden = true, -- find also hidden files
          --   mappings = {
          --     -- your custom insert mode mappings
          --     ['i'] = {
          --       ['<C-w>'] = function() vim.cmd('normal vbd') end,
          --     },
          --     ['n'] = {
          --       -- your custom normal mode mappings
          --       ['N'] = fb_actions.create,
          --       ['h'] = fb_actions.goto_parent_dir,
          --       ['/'] = function() vim.cmd('startinsert') end,
          --     },
          --   },
          -- },
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
      })

      -- telescope.load_extension('file_browser')
      telescope.load_extension('fzf')

      -- keymaps
      local keymap = vim.keymap
      local icon = require('tigion.core.icons').telescope

      -- https://github.com/nvim-telescope/telescope.nvim#pickers
      -- :Telescope builtin

      keymap.set('n', 'öf', builtin.find_files, { desc = icon .. ' Find files in workspace' })
      keymap.set(
        'n',
        'ör',
        '<Cmd>Telescope oldfiles cwd_only=true<CR>',
        { desc = icon .. ' Find previously opened files in workspace' }
      )
      keymap.set('n', 'öb', builtin.buffers, { desc = icon .. ' Find open buffers' })

      keymap.set('n', 'ög', builtin.current_buffer_fuzzy_find, { desc = icon .. ' Find in current buffer' })
      keymap.set('n', 'ögg', builtin.live_grep, { desc = icon .. ' Find in workspace' })
      keymap.set('n', 'öG', builtin.grep_string, { desc = icon .. ' Find string under cursor in workspace' })
      keymap.set('v', 'öG', builtin.grep_string, { desc = icon .. ' Find selection in workspace' })
      keymap.set('n', 'öh', builtin.help_tags, { desc = icon .. ' Find in help' })
      keymap.set('n', 'öd', builtin.diagnostics, { desc = icon .. ' Find in diagnostics' })
      keymap.set('n', 'ö:', builtin.commands, { desc = icon .. ' Find in commands' })
      keymap.set('n', 'ö::', builtin.command_history, { desc = icon .. ' Find in command history' })
      keymap.set('n', 'ö/', builtin.search_history, { desc = icon .. ' Find in search history' })
      -- keymap.set('n', 'öc', builtin.git_bcommits, { desc = icon .. ' Find in git commits in current buffer' })
      -- keymap.set('n', 'öcc', builtin.git_commits, { desc = icon .. ' Find in git commits' })
      keymap.set('n', 'ös', builtin.treesitter, { desc = icon .. ' Find in treesitter symbols' })
      keymap.set('n', 'öö', builtin.resume, { desc = icon .. ' Reopen previous Telescope search' })

      -- keymap.set('n', 'sf', function()
      --   telescope.extensions.file_browser.file_browser({
      --     path = '%:p:h',
      --     cwd = telescope_buffer_dir(),
      --     respect_gitignore = false,
      --     hidden = true,
      --     grouped = true,
      --     previewer = false, -- deactivate preview
      --     initial_mode = 'normal',
      --     layout_config = {
      --       height = 40,
      --     },
      --   })
      -- end, { desc = icon .. ' Open file browser' })
    end,
  },
}
