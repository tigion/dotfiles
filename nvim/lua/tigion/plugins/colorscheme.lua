-- return {
--   'craftzdog/solarized-osaka.nvim',
--   -- enabled = false,
--   lazy = false,
--   priority = 1000,
--   opts = {
--     transparent = true,
--     styles = {
--       sidebars = 'transparent',
--       floats = 'dark',
--     },
--     lualine_bold = true,
--     on_highlights = function(hl, c)
--       -- Neovim
--       hl.FloatBorder = { fg = c.base02, bg = c.bg_float }
--       hl.FloatTitle = { fg = c.cyan, bg = c.bg_float }
--
--       -- Alpha
--       hl.AlphaHeader = { fg = c.orange }
--       hl.AlphaButtons = { fg = c.blue }
--       hl.AlphaShortcut = { fg = c.green }
--       hl.AlphaFooter = { fg = c.base01 }
--
--       -- Telescope
--       hl.TelescopeBorder = { fg = c.blue900, bg = c.bg_float }
--       hl.TelescopeTitle = { fg = c.bg_float, bg = c.blue }
--       hl.TelescopePromptBorder = { fg = c.orange900, bg = c.bg_float }
--       hl.TelescopePromptTitle = { fg = c.bg_float, bg = c.orange }
--       hl.TelescopePromptPrefix = { fg = c.orange, bg = c.none }
--       hl.TelescopePromptCounter = { fg = c.base01, bg = c.none }
--       hl.TelescopePreviewBorder = { fg = c.cyan900, bg = c.bg_float }
--       hl.TelescopePreviewTitle = { fg = c.base02, bg = c.cyan }
--
--       -- Cmp
--       -- hl.CmpDocumentation = { fg = c.none, bg = c.bg_float }
--       hl.CmpDocumentationBorder = { fg = c.base02, bg = c.bg_float }
--       -- hl.CmpDocumentationBorder = { fg = c.bg_float, bg = c.bg_float }
--     end,
--   },
--   config = function(_, opts)
--     require('solarized-osaka').setup(opts)
--
--     -- load the colorscheme here
--     vim.cmd([[colorscheme solarized-osaka]])
--   end,
-- }

return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    style = 'moon', -- moon, storm, night, day
    transparent = true,
    styles = {
      -- Background styles. Can be "dark", "transparent" or "normal"
      sidebars = 'transparent',
      floats = 'dark',
    },
    lualine_bold = true,
    on_colors = function(colors)
      -- bg             = "#222436",
      -- bg_dark        = "#1e2030",
      -- bg_highlight   = "#2f334d",
      -- blue           = "#82aaff",
      -- blue0          = "#3e68d7",
      -- blue1          = "#65bcff",
      -- blue2          = "#0db9d7",
      -- blue5          = "#89ddff",
      -- blue6          = "#b4f9f8",
      -- blue7          = "#394b70",
      -- comment        = "#636da6", -- '#727897'
      -- cyan           = "#86e1fc",
      -- dark3          = "#545c7e",
      -- dark5          = "#737aa2",
      -- fg             = "#c8d3f5",
      -- fg_dark        = "#828bb8",
      -- fg_gutter      = "#3b4261",
      -- green          = "#c3e88d",
      -- green1         = "#4fd6be",
      -- green2         = "#41a6b5",
      -- magenta        = "#c099ff",
      -- magenta2       = "#ff007c",
      -- orange         = "#ff966c",
      -- purple         = "#fca7ea",
      -- red            = "#ff757f",
      -- red1           = "#c53b53",
      -- teal           = "#4fd6be",
      -- terminal_black = "#444a73",
      -- yellow         = "#ffc777",
      -- git = {
      --   add          = "#b8db87",
      --   change       = "#7ca1f2",
      --   delete       = "#e26a75",
      -- }
      colors.comment = '#727897'
    end,
    on_highlights = function(hl, c)
      -- lualine

      -- Telescope
      local c1 = '#14151f'
      hl.TelescopeBorder = { fg = c1, bg = c1 }
      hl.TelescopeNormal = { fg = c.fg, bg = c1 }
      hl.TelescopeTitle = { fg = c.c1, bg = c.blue }
      hl.TelescopePromptTitle = { fg = c.bg_float, bg = c.orange }
      hl.TelescopePromptBorder = { fg = c.bg_float, bg = c.bg_float }
      hl.TelescopePromptNormal = { fg = c.fg, bg = c.bg_float }
      c1 = '#0a0b10'
      hl.TelescopePreviewBorder = { fg = c1, bg = c1 }
      hl.TelescopePreviewNormal = { fg = c.fg, bg = c1 }
    end,
  },
  config = function(_, opts)
    require('tokyonight').setup(opts)
    -- load the colorscheme here
    -- vim.cmd([[colorscheme tokyonight]])
    vim.cmd.colorscheme('tokyonight')
  end,
}

-- return {
--   'catppuccin/nvim',
--   name = 'catppuccin',
--   priority = 1000,
--   opts = {
--     flavour = 'mocha', -- auto, latte, frappe, macchiato, mocha
--     transparent_background = true,
--     -- styles = {
--     -- },
--     -- on_highlights = function(hl, c)
--     --   ...
--     -- end,
--   },
--   config = function(_, opts)
--     require('catppuccin').setup(opts)
--     -- load the colorscheme here
--     vim.cmd([[colorscheme catppuccin]])
--   end,
-- }

-- return {
--   'olimorris/onedarkpro.nvim',
--   priority = 1000,
--   opts = {
--     -- flavour = 'mocha', -- auto, latte, frappe, macchiato, mocha
--     options = {
--       transparency = true,
--     },
--     -- styles = {
--     -- },
--     -- on_highlights = function(hl, c)
--     --   ...
--     -- end,
--   },
--   config = function(_, opts)
--     require('onedarkpro').setup(opts)
--     -- load the colorscheme here
--     vim.cmd([[colorscheme onedark]])
--   end,
-- }
