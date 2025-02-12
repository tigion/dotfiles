return {
  -- This plugin adds a highly extendable fuzzy finder over lists to Neovim.
  -- Link: https://github.com/nvim-telescope/telescope.nvim

  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }, -- fuzzy find
  },
  cmd = 'Telescope', -- used in alpha-nvim
  keys = {
    -- https://github.com/nvim-telescope/telescope.nvim#pickers
    -- :Telescope builtin
    -- Files
    { 'öf', '<Cmd>Telescope find_files<CR>', desc = 'Find files (cwd)' },
    { 'ör', '<Cmd>Telescope oldfiles cwd_only=true<CR>', desc = 'Find recent files (cwd)' },
    -- Buffers
    { 'öb', '<Cmd>Telescope buffers<CR>', desc = 'Find open buffers' },
    -- Strings
    { 'ög', '<Cmd>Telescope current_buffer_fuzzy_find<CR>', desc = 'Find string (buffer)' },
    { 'ögg', '<Cmd>Telescope live_grep<CR>', desc = 'Find string (cwd)' },
    { 'öw', '<Cmd>Telescope grep_string<CR>', mode = { 'n', 'x' }, desc = 'Find current word/selection (cwd)' },
    -- Help tags
    { 'öh', '<Cmd>Telescope help_tags<CR>', desc = 'Find help tags' },
    -- Diagnostics
    { 'öd', '<Cmd>Telescope diagnostics bufnr=0<CR>', desc = 'Find diagnostics (buffer)' },
    { 'ödd', '<Cmd>Telescope diagnostics<CR>', desc = 'Find diagnostics (buffers)' },
    -- Commands and command history
    { 'ö:', '<Cmd>Telescope commands<CR>', desc = 'Find commands' },
    { 'ö::', '<Cmd>Telescope command_history<CR>', desc = 'Find command history' },
    -- Search history
    { 'ö/', '<Cmd>Telescope search_history<CR>', desc = 'Find search history' },
    -- Git
    -- { 'öc', '<Cmd>Telescope git_bcommits<CR>', desc = 'Find git commits (buffer)' },
    -- { 'öcc', '<Cmd>Telescope git_commits<CR>', desc = 'Find git commits' },
    -- Treesitter
    { 'ös', '<Cmd>Telescope treesitter<CR>', desc = 'Find treesitter symbols' },
    -- Register
    { 'öR', '<Cmd>Telescope registers<CR>', desc = 'Find registers' },
    -- Telescope
    --
    { 'öö', '<Cmd>Telescope resume<CR>', desc = 'Reopen previous search' },
    { 'ööö', '<Cmd>Telescope builtin<CR>', desc = 'Find telescope builtin' },
  },
  opts = function()
    local actions = require('telescope.actions')

    return {
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
            -- ['<C-f>'] = actions.preview_scrolling_left, -- NOTE: Not yet in the 0.1.x branch!
            -- ['<C-k>'] = actions.preview_scrolling_right, -- NOTE: Not yet in the 0.1.x branch!
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
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = 'smart_case', -- smart_case (default), ignore_case, respect_case
        },
      },
    }
  end,
  config = function(_, opts)
    local telescope = require('telescope')

    -- Setup with user options
    telescope.setup(opts)

    -- Load extensions
    telescope.load_extension('fzf')
  end,
}
