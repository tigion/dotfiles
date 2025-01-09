return {
  'nvim-tree/nvim-tree.lua', -- file explorer
  dependencies = { 'echasnovski/mini.icons' },
  -- dependencies = 'nvim-tree/nvim-web-devicons', -- optional, for file icons
  cmd = 'NvimTreeOpen', -- used in alpha-nvim
  keys = {
    { '<Leader>e', '<Cmd>NvimTreeToggle<CR>', desc = 'Toggle file explorer' },
  },
  opts = function()
    local icons = require('tigion.core.icons')

    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    return {
      -- disable_netrw = true,
      filters = {
        dotfiles = false,
        custom = { '^\\.git$' }, -- ignore `.git` folder
      },
      git = {
        ignore = false, -- toggle with `I`
      },
      renderer = {
        icons = {
          glyphs = {
            folder = {
              arrow_closed = icons.folding.closed,
              arrow_open = icons.folding.open,
            },
            git = {
              unstaged = icons.git.unstaged, -- ✗
              staged = icons.git.staged, -- ✓
              -- unmerged  = '',
              renamed = icons.git.renamed, -- ➜
              untracked = icons.git.untracked, -- ★
              deleted = icons.git.deleted, -- 
              ignored = icons.git.ignored, -- ◌
            },
          },
        },
        group_empty = true,
      },
      --on_attach = on_attach,
      view = {
        width = 28,
        adaptive_size = false,
        --mappings = {
        --  list = {
        --    { key = 's',     action = '' },
        --    { key = '<C-s>', action = 'system_open' },
        --  },
        --},
      },
      update_focused_file = { enable = true },
    }
  end,
}
