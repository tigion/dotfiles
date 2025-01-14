return {
  -- This plugin is an icon provider to Neovim.
  -- Link: https://github.com/echasnovski/mini.icons

  {
    'echasnovski/mini.icons',
    version = false, -- Main
    opts = {
      file = {
        ['.prettierrc'] = { glyph = '' },
        -- config = { glyph = '󰒓', hl = 'MiniIconsCyan' },
      },
      extension = {
        -- conf = { glyph = '󰒓', hl = 'MiniIconsGray' },
      },
      filetype = {
        -- sh = { glyph = '' },
        kitty = { glyph = '󰒓', hl = 'MiniIconsGray' },
        ghostty = { glyph = '󰒓', hl = 'MiniIconsGray' },
      },
    },
    config = function(_, opts)
      require('mini.icons').setup(opts)
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
}
