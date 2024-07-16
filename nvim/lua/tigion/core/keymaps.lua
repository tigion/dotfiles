-- Keymaps
-- with useful keymaps from devaslife, ThePrimeagen, LazyVim, *

local keymap = vim.keymap

-- Set <space> as the leader key
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Goodies

keymap.set('n', '<Esc><Esc>', ':noh<CR>', { desc = 'Remove search highlights' })
keymap.set('i', 'jj', '<Esc>', { desc = 'Exit insert mode' })
keymap.set('i', 'jk', '<Esc>:w<CR>', { desc = 'Exit insert mode and save' })
keymap.set('i', '<Ctrl-c>', '<Esc>', { desc = 'Exit insert mode' })
keymap.set('n', '<Ctrl-a>', 'gg<S-v>G', { desc = 'Select all' })
-- keymap.set('n', '<Leader>e', ':Lexplore<CR>', { desc = 'Toggle file explorer' }) -- open vim file manager
-- keymap.set('n', '*', '*<Ctrl-o>', { desc = 'Search and go back to initial word' })

-- F-Keys
keymap.set('', '<F8>', ':set relativenumber!<CR>', { desc = 'Toggle relative line numbers' })
keymap.set('', '<F9>', ':set number!<CR>', { desc = 'Toggle line numbers' })
keymap.set('', '<F10>', ':set spell!<CR>', { desc = 'Toggle spell checking' })
-- keymap.set('', '<F10>', ':setlocal spell!<CR>', { desc = 'Toggle spell checking for current buffer' })

-- Navigation

-- keep cursor in middle position when scrolling down / up
keymap.set('n', '<Ctrl-d>', '<Ctrl-d>zz', { desc = 'Scroll down' })
keymap.set('n', '<Ctrl-u>', '<Ctrl-u>zz', { desc = 'Scroll up' })
-- keep cursor in middle position when go to next/prev search result
keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result' })
keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result' })

-- TODO: Testing some special keymaps for german keyboard layout.
keymap.set('n', 'ü', '[', { desc = '[' })
keymap.set('n', 'ä', ']', { desc = ']' })
keymap.set('n', 'Ü', '{zz', { desc = 'Previous empty line' })
keymap.set('n', 'Ä', '}zz', { desc = 'Next empty line' })

-- quickfix/location list

-- quickfix list
-- keymap.set('n', '<Leader>xq', '<Cmd>copen<CR>', { desc = 'Open quickfix list' })
keymap.set('n', '<Leader>xq', function()
  for _, win in pairs(vim.fn.getwininfo()) do
    if win['quickfix'] == 1 then
      vim.cmd.cclose()
      return
    end
  end
  vim.cmd.copen()
end, { desc = 'Toggle quickfix list' })
keymap.set('n', '+q', '<Cmd>cnext<CR>zz', { desc = 'Next quickfix' })
keymap.set('n', 'üq', '<Cmd>cprev<CR>zz', { desc = 'Previous quickfix' })

-- location list
-- keymap.set('n', '<Leader>xl', '<Cmd>lopen<CR>', { desc = 'Open location list' })
keymap.set('n', '<Leader>xl', function()
  if vim.fn.getloclist(0, { winid = 0 }).winid == 0 then
    if not pcall(vim.cmd.lopen) then print('No location list available') end
  else
    vim.cmd.lclose()
  end
end, { desc = 'Toggle location list' })
keymap.set('n', '+l', '<Cmd>lnext<CR>zz', { desc = 'Next location' })
keymap.set('n', 'ül', '<Cmd>lprev<CR>zz', { desc = 'Previous location' })

-- Manipulation

-- better identing (repeatable)
keymap.set('x', '<', '<gv', { desc = 'Decrease indent' })
keymap.set('x', '>', '>gv', { desc = 'Increase indent' })
-- dont affect register
keymap.set('n', 'x', '"_x') -- delete character without copying (register)
-- ('v', P') -> keymap.set('x', '<Leader>p', [["_dP]]) -- preserve highlight source
-- move highlighted line
keymap.set('x', 'J', ":m '>+1<CR>gv=gv") -- down
keymap.set('x', 'K', ":m '<-2<CR>gv=gv") -- up
-- keep cursor position with line concatenation
keymap.set('n', 'J', 'mzJ`z')
-- search and replace template for the current word under cursor
keymap.set(
  'n',
  '<Leader>s',
  [[:%s/\<<Ctrl-r><Ctrl-w>\>/<Ctrl-r><Ctrl-w>/gI<Left><Left><Left>]],
  { desc = 'Substitute current word' }
)
-- increment/decrement numbers
keymap.set('n', '<leader>+', '<Ctrl-a>', { desc = 'Increment number' }) -- increment
keymap.set('n', '<leader>-', '<Ctrl-x>', { desc = 'Decrement number' }) -- decrement
-- keymap.set('n', 'dw', 'vb"_d', { desc = 'Delete a word backwards not forwards' })

-- Windows

-- Split window
keymap.set('n', 'sh', ':split<Return>', { desc = 'Split window horizontally' })
keymap.set('n', 'sv', ':vsplit<Return>', { desc = 'Split window vertically' })
-- Switch window
-- keymap.set('n', '<Ctrl-Space', '<Ctrl-w>w', { desc = 'Go to next window' })
keymap.set('', '<Ctrl-h>', '<Ctrl-w>h', { desc = 'Go to left window' })
keymap.set('', '<Ctrl-j>', '<Ctrl-w>j', { desc = 'Go to lower window' })
keymap.set('', '<Ctrl-k>', '<Ctrl-w>k', { desc = 'Go to upper window' })
keymap.set('', '<Ctrl-l>', '<Ctrl-w>l', { desc = 'Go to right window' })
-- keymap.set('', 'sh', '<Ctrl-w>h', { desc = 'Go to left window' })
-- keymap.set('', 'sj', '<Ctrl-w>j', { dess = 'Go to lower window' })
-- keymap.set('', 'sk', '<Ctrl-w>k', { desc = 'Go to upper window' })
-- keymap.set('', 'sl', '<Ctrl-w>l', { desc = 'Go to right window' })
-- Resize window
keymap.set('n', '<Ctrl-w><Left>', '<Ctrl-w><', { desc = 'Decrease window width' })
keymap.set('n', '<Ctrl-w><Right>', '<Ctrl-w>>', { desc = 'Increase window width' })
keymap.set('n', '<Ctrl-w><Down>', '<Ctrl-w>-', { desc = 'Decrease window height' })
keymap.set('n', '<Ctrl-w><Up>', '<Ctrl-w>+', { desc = 'Increase window height' })

-- Tabs
