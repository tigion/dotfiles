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
    style = 'moon', -- moon, night, (storm, day)
    transparent = true,
    styles = {
      -- dark, transparent or normal
      sidebars = 'transparent',
      floats = 'dark',
    },
    lualine_bold = true,
    -- Color code notes are in `nvim/docs/colors.md`
    --
    -- TODO: Use `on_colors` or `style = `custom` to modify the colors?
    --       - https://github.com/folke/tokyonight.nvim/issues/595
    --
    on_colors = function(colors)
      colors.comment = '#626784' -- use a more gray comment
    end,
    on_highlights = function(hl, c)
      -- Telescope
      local own_bg = '#14151f'
      hl.TelescopeBorder = { fg = own_bg, bg = own_bg }
      hl.TelescopeNormal = { fg = c.fg, bg = own_bg }
      hl.TelescopeTitle = { fg = c.c1, bg = c.blue }
      hl.TelescopePromptTitle = { fg = c.bg_float, bg = c.orange }
      hl.TelescopePromptBorder = { fg = c.bg_float, bg = c.bg_float }
      hl.TelescopePromptNormal = { fg = c.fg, bg = c.bg_float }
      own_bg = '#0a0b10'
      hl.TelescopePreviewBorder = { fg = own_bg, bg = own_bg }
      hl.TelescopePreviewNormal = { fg = c.fg, bg = own_bg }
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
