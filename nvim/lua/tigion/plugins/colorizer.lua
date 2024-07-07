-- return {
--   'norcalli/nvim-colorizer.lua', -- colored color codes
--   enabled = true,
--   opts = {
--     '*',
--     -- default: RGB, RRGGBB, names
--     css = {
--       css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
--     },
--   },
-- }

return {
  'NvChad/nvim-colorizer.lua', -- colored color codes
  enabled = true,
  opts = {
    -- default: RGB, RRGGBB, names
    user_default_options = {
      RGB = true,
      RRGGBB = true,
      names = false,
      -- mode = 'virtualtext',
    },
    filetypes = {
      '*', -- Highlight all files, but customize some others.
      css = { css = true }, -- Enable parsing rgb(...) functions in css.
    },
  },
}
