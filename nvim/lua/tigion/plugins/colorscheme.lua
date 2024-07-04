return {
  'craftzdog/solarized-osaka.nvim',
  -- enabled = false,
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    styles = {
      sidebars = 'transparent',
      floats = 'dark',
    },
    lualine_bold = true,
    on_highlights = function(hl, c)
      -- Neovim
      hl.FloatBorder = { fg = c.base02, bg = c.bg_float }
      hl.FloatTitle = { fg = c.cyan, bg = c.bg_float }
      -- Alpha
      hl.AlphaHeader = { fg = c.orange }
      hl.AlphaButtons = { fg = c.blue }
      hl.AlphaShortcut = { fg = c.green }
      hl.AlphaFooter = { fg = c.base01 }
      -- Telescope
      hl.TelescopeBorder = { fg = c.blue900, bg = c.bg_float }
      hl.TelescopeTitle = { fg = c.bg_float, bg = c.blue }
      hl.TelescopePromptBorder = { fg = c.orange900, bg = c.bg_float }
      hl.TelescopePromptTitle = { fg = c.bg_float, bg = c.orange }
      hl.TelescopePromptPrefix = { fg = c.orange, bg = c.none }
      hl.TelescopePromptCounter = { fg = c.base01, bg = c.none }
      hl.TelescopePreviewBorder = { fg = c.cyan900, bg = c.bg_float }
      hl.TelescopePreviewTitle = { fg = c.base02, bg = c.cyan }
      -- Cmp
      -- hl.CmpDocumentation = { fg = c.none, bg = c.bg_float }
      hl.CmpDocumentationBorder = { fg = c.base02, bg = c.bg_float }
      -- hl.CmpDocumentationBorder = { fg = c.bg_float, bg = c.bg_float }
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
