-- Autocommands

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  command = 'set nopaste',
})

-- Highlight when yanking (copying) text (on `yy` or `yap` for example)
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
  callback = function() vim.highlight.on_yank({ higroup = 'Visual' }) end,
})

-- Go to last cursor location when opening a buffer
-- Inspired by: https://github.com/LazyVim/LazyVim/blob/f9dadc11b39fb0b027473caaab2200b35c9f0c8b/lua/lazyvim/config/autocmds.lua#L31C1-L46C3
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Go to last cursor location when opening a buffer',
  group = vim.api.nvim_create_augroup('go_to_last_location', { clear = true }),
  callback = function(event)
    local exclude = { 'gitcommit' } -- excluded filetypes
    local buf = event.buf -- current buffer
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].got_last_location then return end
    vim.b[buf].got_last_location = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"') -- get last cursor position
    local line_count = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark) -- set and scroll to position in mark
      -- middle line (if possible)
      -- NOTE: This needs a short delay in order to work.
      vim.defer_fn(function() vim.api.nvim_command([[keepjumps normal! zz]]) end, 10)
      -- Other variants (optional with zz -> g`"zz):
      -- vim.api.nvim_command([[keepjumps normal! g`"]])
      -- vim.cmd('normal! g`"')
    end
  end,
})
