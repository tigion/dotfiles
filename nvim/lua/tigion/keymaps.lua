local keymap = vim.keymap

-- My keymaps
keymap.set("n", "<Esc><Esc>", ":noh<cr>") -- clear search highlighting
keymap.set('i', 'jj', '<Esc>') -- also `jj` for <Esc>
-- search and go back to start of current word
--keymap.set('n', '*', '*<C-o>')
-- F-Keys
keymap.set('', '<F8>', ':set relativenumber!<Cr>') -- toggle relative line numbers
keymap.set('', '<F9>', ':set number!<Cr>') -- toggle line numbers
keymap.set('', '<F10>', ':set spell!<Cr>') -- toggle spell checking

-- [[Good keymaps from ThePrimeagen]]
-- open vim file manager
--keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- move highlight line down / up
keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- down
keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- up
-- keep cursor position with line concatenation
keymap.set("n", "J", "mzJ`z")
-- keep cursor in middle position when scrolling down / up
keymap.set("n", "<C-d>", "<C-d>zz") -- down
keymap.set("n", "<C-u>", "<C-u>zz") -- up
-- keep cursor in middle position when go to next/prev search result
keymap.set("n", "n", "nzzzv") -- next
keymap.set("n", "N", "Nzzzv") -- prev
-- preserve highligh tsource
keymap.set("x", "<leader>p", [["_dP]])
-- let `<C-c>` act like `<Esc>`
keymap.set("i", "<C-c>", "<Esc>")
-- ...
--keymap.set("n", "Q", "<nop>")
-- ...
--keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- format / indent current buffer with lsp
keymap.set("n", "<leader>f", vim.lsp.buf.format)
-- quick fix navigation
keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
-- search and replace template for the current word under cursor
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- [[Good keymaps from devaslife]]
-- ?
keymap.set('n', 'x', '"_x')
-- Increment/decrement
--keymap.set('n', '+', '<C-a>')
--keymap.set('n', '-', '<C-x>')
-- Delete a word backwards not forwards
--keymap.set('n', 'dw', 'vb"_d')
-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')
-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})
-- New tab
keymap.set('n', 'te', ':tabedit')
-- Split window
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
-- Switch window
keymap.set('n', '<Leader><Tab>', '<C-w>w')
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')
-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')
