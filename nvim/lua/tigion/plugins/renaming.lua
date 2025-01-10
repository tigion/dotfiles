return {
  -- This plugin adds a command for LSP renaming with immediate
  -- visual feedback to Neovim.
  -- Link: https://github.com/smjonas/inc-rename.nvim

  'smjonas/inc-rename.nvim',
  event = 'VeryLazy',
  cmd = 'IncRename',
  keys = {
    {
      '<Leader>rn',
      function() return ':IncRename ' .. vim.fn.expand('<cword>') end,
      desc = 'Rename with references (IncRename)',
      expr = true,
    },
  },
  opts = {
    -- NOTE: The input in the command line and in the popup window of
    -- dressing is irritating. So I'm disabling it for now.
    --
    -- input_buffer_type = 'dressing',
  },
}
