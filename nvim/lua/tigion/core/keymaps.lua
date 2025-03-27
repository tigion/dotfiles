-- Keymaps
-- with useful keymaps from devaslife, ThePrimeagen, LazyVim, *

-- NOTE: `:h <Cmd>`, `:h :` for more info
-- - The <Cmd> pseudokey begins a "command mapping", which executes the command
--   directly without changing modes. `:...<CR>` -> `<Cmd>...<CR>`
-- - <Cmd> avoids mode-changes (unlike ":") it does not triggers
--   `CmdlineEnter` and `CmdlineLeave` events. This helps performance.
-- - Whit <Cmd> the command is not echo'ed, no need for `silent = true`.
-- - <Cmd> commands must terminate, that is, they must be followed by <CR>.

local keymap = vim.keymap

local toggle = require('tigion.core.util').toggle
local addons = require('tigion.core.addons')

-- Set <space> as the leader key
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Options ---------------------------------------------------------------------
-- NOTE:
-- Set global and local option:     `:set`,       `vim.o`,      `vim.opt`
-- Set only local no global option: `:setlocal`,  `vim.[w|b]o`, `vim.opt_local`
-- Set only global no local option: `:setglobal`, `vim.og`,     `vim.opt_global`
-- vim.o      ... string
-- vim.opt    ... table

-- Global options
keymap.set('', '<F7>', '<Cmd>set wrap!<CR>', { desc = 'Toggle line wrap' })

-- Navigation ------------------------------------------------------------------

-- Spelling
keymap.set('n', '<Leader>tos', '<Cmd>setlocal spell!<CR>', { desc = 'Toggle spell checking (local)' })

-- Diagnostics
keymap.set('n', '<Leader>td', toggle.diagnostics_visibility, { desc = 'Toggle diagnostics visibility' })

-- Quickfix list
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
-- keymap.set('n', ']q', '<Cmd>cnext<CR>zz', { desc = 'Next quickfix' })
-- keymap.set('n', '<C-n>', '<Cmd>cnext<CR>zz', { desc = 'Next quickfix' })
-- keymap.set('n', '[q', '<Cmd>cprev<CR>zz', { desc = 'Prev quickfix' })
-- keymap.set('n', '<C-q>', '<Cmd>cprev<CR>zz', { desc = 'Prev quickfix' })

-- Location list
-- keymap.set('n', '<Leader>xl', '<Cmd>lopen<CR>', { desc = 'Open location list' })
keymap.set('n', '<Leader>xl', function()
  if vim.fn.getloclist(0, { winid = 0 }).winid == 0 then
    if not pcall(vim.cmd.lopen) then print('No location list available') end
  else
    vim.cmd.lclose()
  end
end, { desc = 'Toggle location list' })
-- keymap.set('n', ']l', '<Cmd>lnext<CR>zz', { desc = 'Next location' })
-- keymap.set('n', '[l', '<Cmd>lprev<CR>zz', { desc = 'Prev location' })

-- Manipulation ----------------------------------------------------------------

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

-- Sustitute (search and replace)
keymap.set('n', '<Leader>ss', [[:%s/\v]], { desc = 'Substitute template' })
keymap.set('x', '<Leader>ss', [[:s/\v]], { desc = 'Substitute template' })
keymap.set(
  'n',
  '<Leader>sw',
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = 'Substitute current word' }
)

-- increment/decrement numbers
keymap.set('n', '<Leader>+', '<C-a>', { desc = 'Increment number' }) -- increment
keymap.set('n', '<Leader>-', '<C-x>', { desc = 'Decrement number' }) -- decrement

-- Switch word under cursor to opposite word
-- keymap.set('n', '<Leader>i', addons.switch_word_to_opposite_word, { desc = 'Switch to opposite word' })

-- Buffers ---------------------------------------------------------------------

keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })

-- Windows ---------------------------------------------------------------------

-- Split window
keymap.set('n', 'sh', '<Cmd>split<Return>', { desc = 'Split window horizontally' })
keymap.set('n', 'sv', '<Cmd>vsplit<Return>', { desc = 'Split window vertically' })

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

-- Tabs ------------------------------------------------------------------------

-- Other -----------------------------------------------------------------------

-- Help for word under cursor (lua: vim.fn.expand('<cword>'))
keymap.set('n', '<Leader>K', [[:help <C-r><C-w><CR>]], { desc = 'Help for word under cursor' })

-- Inspect (Treesitter) highlights (under cursor)
keymap.set('n', '<Leader>ui', '<Cmd>Inspect<CR>', { desc = 'Inspect Pos' })
keymap.set('n', '<Leader>uI', '<Cmd>InspectTree<CR>', { desc = 'Inspect Tree' })
