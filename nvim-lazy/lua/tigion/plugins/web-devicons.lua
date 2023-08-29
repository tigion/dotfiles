return {
  'nvim-tree/nvim-web-devicons', -- file icons
  -- opts = {
  --   default = true,
  -- },
  config = function()
    local status, icons = pcall(require, 'nvim-web-devicons')
    if not status then return end

    icons.setup {
      -- your personal icons can go here (to override)
      -- DevIcon will be appended to `name`
      -- override = {},
      override = {},
      -- globally enable different highlight colors per icon (default to true)
      -- if set to false all icons will have the default icon's color
      color_icons = true,
      -- globally enable default icons (default to false)
      -- will get overriden by `get_icons` option
      default = true,
    }
  end,
}