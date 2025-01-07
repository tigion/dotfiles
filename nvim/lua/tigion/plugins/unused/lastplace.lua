return {
  'ethanholz/nvim-lastplace', -- reopen files at last edit position
  enabled = false,
  opts = {
    lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
    lastplace_ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' },
    lastplace_open_folds = true,
  },
}

-- local status, lastplace = pcall(require, 'nvim-lastplace')
-- if (not status) then return end
--
-- lastplace.setup {
--   lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
--   lastplace_ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' },
--   lastplace_open_folds = true,
-- }
