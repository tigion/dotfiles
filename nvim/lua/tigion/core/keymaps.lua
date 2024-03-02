-- Keymaps
-- with useful keymaps from devaslife, ThePrimeagen, LazyVim, *

local keymap = vim.keymap

-- Goodies

keymap.set('n', '<Esc><Esc>', ':noh<CR>', { desc = 'Remove search highlights' })
keymap.set('i', 'jj', '<Esc>', { desc = 'Exit insert mode' })
keymap.set('i', '<C-c>', '<Esc>', { desc = 'Exit insert mode' })
keymap.set('n', '<C-a>', 'gg<S-v>G', { desc = 'Select all' })
-- keymap.set('n', '<Leader>e', ':Lexplore<CR>', { desc = 'Toggle file explorer' }) -- open vim file manager
-- keymap.set('n', '*', '*<C-o>', { desc = 'Search and go back to initial word' })

-- F-Keys
keymap.set('', '<F8>', ':set relativenumber!<CR>', { desc = 'Toggle relative line numbers' })
keymap.set('', '<F9>', ':set number!<CR>', { desc = 'Toggle line numbers' })
keymap.set('', '<F10>', ':set spell!<CR>', { desc = 'Toggle spell checking' })
-- keymap.set('', '<F10>', ':setlocal spell!<CR>', { desc = 'Toggle spell checking for current buffer' })

-- Navigation

-- keep cursor in middle position when scrolling down / up
keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down' })
keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up' })
-- keep cursor in middle position when go to next/prev search result
keymap.set('n', 'n', 'nzzzv', { desc = 'Go to next search result' })
keymap.set('n', 'N', 'Nzzzv', { desc = 'Go to prev search result' })

-- quickfix/location list
-- keymap.set('n', 'xq', '<Cmd>copen<CR>', { desc = 'Open quickfix list' })
keymap.set('n', 'üq', '<Cmd>cnext<CR>zz', { desc = 'Go to next quickfix item' })
keymap.set('n', '+q', '<Cmd>cprev<CR>zz', { desc = 'Go to prev quickfix item' })
-- keymap.set('n', 'xl', '<Cmd>lopen<CR>', { desc = 'Open location list' })
keymap.set('n', 'ül', '<Cmd>lnext<CR>zz', { desc = 'Go to next location item' })
keymap.set('n', '+l', '<Cmd>lprev<CR>zz', { desc = 'Go to prev location item' })

-- Manipulation

-- better identing (repeatable)
keymap.set('v', '<', '<gv', { desc = 'Decrease indent' })
keymap.set('v', '>', '>gv', { desc = 'Increase indent' })
-- dont affect register
keymap.set('n', 'x', '"_x') -- delete character without copying (register)
-- ('v', P') -> keymap.set('x', '<Leader>p', [["_dP]]) -- preserve highlight source
-- move highlighted line
keymap.set('v', 'J', ":m '>+1<CR>gv=gv") -- down
keymap.set('v', 'K', ":m '<-2<CR>gv=gv") -- up
-- keep cursor position with line concatenation
keymap.set('n', 'J', 'mzJ`z')
-- search and replace template for the current word under cursor
keymap.set(
  'n',
  '<Leader>s',
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = 'Search and replace word under cursor' }
)
-- keymap.set('n', 'dw', 'vb"_d', { desc = 'Delete a word backwards not forwards' })

-- Windows

-- Split window
keymap.set('n', 'sh', ':split<Return><C-w>w', { desc = 'Split window horizontally' })
keymap.set('n', 'sv', ':vsplit<Return><C-w>w', { desc = 'Split window vertically' })
-- Switch window
-- keymap.set('n', '<C-Space', '<C-w>w', { desc = 'Go to next window' })
keymap.set('', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
keymap.set('', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
keymap.set('', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
keymap.set('', '<C-l>', '<C-w>l', { desc = 'Go to right window' })
-- keymap.set('', 'sh', '<C-w>h', { desc = 'Go to left window' })
-- keymap.set('', 'sj', '<C-w>j', { dess = 'Go to lower window' })
-- keymap.set('', 'sk', '<C-w>k', { desc = 'Go to upper window' })
-- keymap.set('', 'sl', '<C-w>l', { desc = 'Go to right window' })
-- Resize window
keymap.set('n', '<C-w><Left>', '<C-w><', { desc = 'Decrease window width' })
keymap.set('n', '<C-w><Right>', '<C-w>>', { desc = 'Increase window width' })
keymap.set('n', '<C-w><Down>', '<C-w>-', { desc = 'Decrease window height' })
keymap.set('n', '<C-w><Up>', '<C-w>+', { desc = 'Increase window height' })

-- Tabs
