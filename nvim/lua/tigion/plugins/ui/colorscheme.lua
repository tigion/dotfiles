-- NOTE: Color code notes are in `nvim/docs/colors.md`

return {
  -- This plugin adds a color scheme to Neovim.
  -- Link: https://github.com/folke/tokyonight.nvim

  -- WARN: To clear the theme color cache after changing highlight
  -- groups use `:lua require("tokyonight.util").cache.clear()`

  -- TODO: Use `on_colors` or `style = `custom` to modify the colors?
  -- - https://github.com/folke/tokyonight.nvim/issues/595

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
    on_colors = function(colors)
      colors.bg = '#1a1b26' -- Use the darker background of 'night' style.
      colors.comment = '#626784' -- Use a more gray comment.
    end,
    on_highlights = function(hl, c)
      --      #1e1f2c / hsl(234, 18.75%, 14.55%)
      --      #1c1d29 / hsl(235, 18.75%, 13.55%)
      -- bg = #1a1b26 / hsl(235, 18.75%, 12.55%)
      --      #181923 / hsl(235, 18.75%, 11.55%)
      --      #161720 / hsl(235, 18.75%, 10.55%)
      --      #14151d / hsl(235, 18.75%,  9.55%)
      --      #12121a / hsl(235, 18.75%,  8.55%)

      -- darker bg_float variants
      local bg_float1 = c.bg_float
      local bg_float2 = '#161720'
      local bg_float3 = '#12121a'

      -- cmp-nvim
      -- hl.CmpDocumentation.bg = bg_float2
      -- hl.CmpDocumentationBorder = { fg = c.comment, bg = bg_float2 }

      -- blink.cmp
      hl.BlinkCmpSource = { fg = c.comment }
      hl.BlinkCmpDoc.bg = bg_float2
      hl.BlinkCmpDocBorder = { fg = c.comment, bg = hl.BlinkCmpDoc.bg }
      hl.BlinkCmpDocSeparator = hl.BlinkCmpDocBorder

      -- Telescope
      hl.TelescopeNormal = { fg = c.fg, bg = bg_float2 }
      hl.TelescopeTitle = { fg = bg_float2, bg = c.blue }
      hl.TelescopeBorder = { fg = bg_float2, bg = bg_float2 }
      hl.TelescopePromptNormal = { fg = c.fg, bg = bg_float1 }
      hl.TelescopePromptTitle = { fg = bg_float1, bg = c.orange }
      hl.TelescopePromptBorder = { fg = bg_float1, bg = bg_float1 }
      hl.TelescopePreviewTitle = { fg = bg_float3, bg = c.magenta }
      hl.TelescopePreviewNormal = { fg = c.fg, bg = bg_float3 }
      hl.TelescopePreviewBorder = { fg = bg_float3, bg = bg_float3 }

      -- Snacks.picker
      hl.SnacksPicker = { fg = c.fg, bg = bg_float2 }
      hl.SnacksPickerTitle = { fg = bg_float2, bg = c.blue }
      -- hl.SnacksPickerBorder = { fg = c.blue, bg = bg_float2 }
      hl.SnacksPickerBorder = { fg = bg_float2, bg = bg_float2 }
      hl.SnacksPickerPreviewVisual = { fg = c.fg, bg = c.red }
      hl.SnacksPickerInput = { fg = c.fg, bg = bg_float1 }
      hl.SnacksPickerInputTitle = { fg = bg_float1, bg = c.orange }
      -- hl.SnacksPickerInputBorder = { fg = c.orange, bg = bg_float1 }
      hl.SnacksPickerInputBorder = { fg = bg_float1, bg = bg_float1 }
      hl.SnacksPickerPreview = { fg = c.fg, bg = bg_float3 }
      hl.SnacksPickerPreviewTitle = { fg = bg_float3, bg = c.magenta }
      -- hl.SnacksPickerPreviewBorder = { fg = c.magenta, bg = bg_float3 }
      hl.SnacksPickerPreviewBorder = { fg = bg_float3, bg = bg_float3 }
      hl.SnacksPickerBoxTitle = { fg = bg_float1, bg = c.orange }
      hl.SnacksPickerBoxBorder = { fg = bg_float1, bg = bg_float1 }
      -- hl.SnacksPickerBoxBorder = { fg = c.blue, bg = bg_float1 }

      -- NvimTree
      hl.NvimTreeExecFile = { fg = c.red }
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
--  -- This plugin adds a color scheme to Neovim.
--  -- Link: https://github.com/craftzdog/solarized-osaka.nvim
--
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

-- return {
--  -- This plugin adds a color scheme to Neovim.
--  -- Link: https://github.com/catppuccin/nvim
--
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
--  -- This plugin adds a color scheme to Neovim.
--  -- Link: https://github.com/olimorris/onedarkpro.nvim
--
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
