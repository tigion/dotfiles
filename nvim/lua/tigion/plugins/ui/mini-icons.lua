return {
  -- This plugin is an icon provider to Neovim.
  -- Link: https://github.com/echasnovski/mini.icons

  {
    'echasnovski/mini.icons',
    version = false, -- Main
    opts = {},
    config = function(_, opts)
      require('mini.icons').setup(opts)
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
}
