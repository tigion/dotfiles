return {
  'nvim-tree/nvim-tree.lua', -- file explorer
  dependencies = 'nvim-tree/nvim-web-devicons', -- optional, for file icons
  config = function()
    local tree = require('nvim-tree')
    local icons = require('tigion.core.icons')

    tree.setup({
      -- disable_netrw = true,
      hijack_netrw = false,
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
    })

    vim.keymap.set('n', '<Leader>e', ':NvimTreeToggle<Cr>', { silent = true, desc = 'Toggle file explorer' })
  end,
}
