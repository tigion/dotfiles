return {
  -- This plugin adds a moving around your code in a syntax tree
  -- aware manner to Neovim.
  -- Link: https://github.com/aaronik/treewalker.nvim

  'aaronik/treewalker.nvim',
  keys = {
    { 'äj', '<CMD>Treewalker Down<CR>' },
    { 'äk', '<CMD>Treewalker Up<CR>' },
    { 'äh', '<CMD>Treewalker Left<CR>' },
    { 'äl', '<CMD>Treewalker Right<CR>' },
  },
  opts = {},
}
