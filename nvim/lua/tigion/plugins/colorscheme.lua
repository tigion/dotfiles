return {
  'craftzdog/solarized-osaka.nvim',
  -- enabled = false,
  lazy = false,
  priority = 1000,
  opts = {
    styles = {
      sidebars = 'transparent',
      floats = 'dark',
    },
    lualine_bold = true,
    on_highlights = function(hl, c)
      hl.AlphaHeader = { fg = c.orange }
      hl.AlphaButtons = { fg = c.blue }
      hl.AlphaShortcut = { fg = c.green }
      hl.AlphaFooter = { fg = c.base01 }
    end,
  },
  config = function(_, opts)
    require('solarized-osaka').setup(opts)

    -- load the colorscheme here
    vim.cmd([[colorscheme solarized-osaka]])
  end,
}
-- return {
--   'folke/tokyonight.nvim',
--   lazy = false,
--   priority = 1000,
--   opts = {
--     style = 'moon',
--     transparent = true,
--     styles = {
--       sidebars = 'transparent',
--       floats = 'dark',
--     },
--     -- on_highlights = function(hl, c)
--     --   ...
--     -- end,
--   },
--   config = function(_, opts)
--     require('tokyonight').setup(opts)
--     -- load the colorscheme here
--     vim.cmd([[colorscheme tokyonight]])
--   end,
-- }
