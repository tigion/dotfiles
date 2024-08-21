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
keymap.set('i', '<C-c>', '<Esc>', { desc = 'Exit insert mode' })
keymap.set('n', '<C-a>', 'gg<S-v>G', { desc = 'Select all' })
-- keymap.set('n', '<Leader>e', ':Lexplore<CR>', { desc = 'Toggle file explorer' }) -- open vim file manager
keymap.set('n', '*', '*<C-o>', { desc = 'Search and go back to initial word' })

-- F-Keys
keymap.set('', '<F7>', ':set wrap!<CR>', { desc = 'Toggle line break' })
keymap.set('', '<F8>', ':set relativenumber!<CR>', { desc = 'Toggle relative line numbers' })
keymap.set('', '<F9>', ':set number!<CR>', { desc = 'Toggle line numbers' })
keymap.set('', '<F10>', ':set spell!<CR>', { desc = 'Toggle spell checking' })
-- keymap.set('', '<F10>', ':setlocal spell!<CR>', { desc = 'Toggle spell checking for current buffer' })

-- Navigation

-- TODO: Testing some special keymaps for german keyboard layout.
--
-- keymap.set('n', 'ü', '[', { desc = '[' })
-- keymap.set('n', 'ä', ']', { desc = ']' })
keymap.set('n', 'üm', '[m', { desc = 'Prev method start' })
keymap.set('n', '+m', ']m', { desc = 'Next method start' })
keymap.set('n', 'üM', '[M', { desc = 'Prev method end' })
keymap.set('n', '+M', ']m', { desc = 'Next method start' })
keymap.set('n', 'Ü', '{', { desc = 'Prev empty line' })
keymap.set('n', 'Ä', '}', { desc = 'Next empty line' })

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
keymap.set('n', 'üq', '<Cmd>cprev<CR>zz', { desc = 'Prev quickfix' })

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
keymap.set('n', 'ül', '<Cmd>lprev<CR>zz', { desc = 'Prev location' })

-- Manipulation

-- better identing (repeatable)
keymap.set('x', '<', '<gv', { desc = 'Decrease indent' })
keymap.set('x', '>', '>gv', { desc = 'Increase indent' })

-- dont affect register
keymap.set('n', 'x', '"_x') -- delete character without copying (register)
-- ('v', P') -> keymap.set('x', '<Leader>p', [["_dP]]) -- preserve highlight source
--
-- move highlighted line
keymap.set('x', 'J', ":m '>+1<CR>gv=gv") -- down
keymap.set('x', 'K', ":m '<-2<CR>gv=gv") -- up

-- keep cursor position with line concatenation
-- keymap.set('n', 'J', 'mzJ`z')
--
-- search and replace template for the current word under cursor
keymap.set(
  'n',
  '<Leader>s',
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = 'Substitute current word' }
)

-- increment/decrement numbers
keymap.set('n', '<leader>+', '<C-a>', { desc = 'Increment number' }) -- increment
keymap.set('n', '<leader>-', '<C-x>', { desc = 'Decrement number' }) -- decrement

-- Buffers
-- keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
-- keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
keymap.set('n', 'üb', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
keymap.set('n', '+b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })

-- Windows

-- Split window
keymap.set('n', 'sh', ':split<Return>', { desc = 'Split window horizontally' })
keymap.set('n', 'sv', ':vsplit<Return>', { desc = 'Split window vertically' })

-- Switch window
-- keymap.set('n', '<C-Space', '<C-w>w', { desc = 'Go to next window' })
keymap.set('', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
keymap.set('', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
keymap.set('', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
keymap.set('', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- Resize window
keymap.set('n', '<C-w><Left>', '<Cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
keymap.set('n', '<C-w><Down>', '<Cmd>resize -2<CR>', { desc = 'Decrease window height' })
keymap.set('n', '<C-w><Up>', '<Cmd>resize +2<CR>', { desc = 'Increase window height' })
keymap.set('n', '<C-w><Right>', '<Cmd>vertical resize +2<CR>', { desc = 'Increase window width' })

-- Tabs

-- Sessions
keymap.set('n', '<Leader>ws', require('tigion.core.util').session.save, { desc = 'Save session (cwd)' })
keymap.set('n', '<Leader>wl', require('tigion.core.util').session.load, { desc = 'Load session (cwd)' })

-- Other

-- Inspect (Treesitter) highlights (under cursor)
keymap.set('n', '<Leader>ui', '<Cmd>Inspect<CR>', { desc = 'Inspect Pos' })
keymap.set('n', '<Leader>uI', '<Cmd>InspectTree<CR>', { desc = 'Inspect Tree' })
