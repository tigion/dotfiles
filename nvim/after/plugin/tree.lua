local status, tree = pcall(require, 'nvim-tree')
if not status then return end

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
          arrow_closed = '⏵',
          arrow_open = '⏷',
        },
      },
    },
    group_empty = true,
  },
  view = {
    adaptive_size = false,
    mappings = {
      list = {
        { key = 's', action = '' },
        { key = '<C-s>', action = 'system_open' },
      },
    },
  },
}

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<Cr>', { silent = true })
