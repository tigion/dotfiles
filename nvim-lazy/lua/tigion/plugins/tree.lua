return {
  'nvim-tree/nvim-tree.lua',                    -- file explorer
  dependencies = 'nvim-tree/nvim-web-devicons', -- optional, for file icons
  config = function()
    local tree = require('nvim-tree')

    tree.setup {
      --disable_netrw = true,
      hijack_netrw = false,
      --auto_close = true, -- has been removed
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
              arrow_closed = '▸',
              arrow_open = '▾',
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

    vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<Cr>', { silent = true })
  end,
}