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
  callback = function() vim.hl.on_yank({ higroup = 'Visual' }) end,
})

-- Go to last cursor location when opening a buffer
-- Inspired by: https://github.com/LazyVim/LazyVim/blob/f9dadc11b39fb0b027473caaab2200b35c9f0c8b/lua/lazyvim/config/autocmds.lua#L31C1-L46C3
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Go to last cursor location when opening a buffer',
  group = vim.api.nvim_create_augroup('go_to_last_location', { clear = true }),
  callback = function(args)
    -- FIX: The filetype is not yet set when the event `BufReadPost` is triggered.
    --
    -- local exclude = { gitcommit = true }
    -- if exclude[vim.bo[args.buf].filetype] or vim.b[args.buf].got_last_location then return end

    -- Don't fire twice for the same buffer.
    if vim.b[args.buf].got_last_location then return end
    vim.b[args.buf].got_last_location = true

    local mark = vim.api.nvim_buf_get_mark(args.buf, '"') -- get last cursor position
    -- Checks if the cursor in in the range of the file.
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_buf_call(args.buf, function()
        vim.cmd('keepjumps normal! g`"')
        -- NOTE: `zz` needs a short delay in order to work in splits.
        vim.defer_fn(function() vim.cmd('keepjumps normal! zz') end, 10)
      end)
    end
  end,
})
