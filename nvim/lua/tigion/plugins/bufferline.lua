return {
  'akinsho/bufferline.nvim', -- styled tabs
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional, for file icons
  version = '*',
  event = 'VeryLazy',
  -- keys = {
  --  FIX: Keymap `+t` doesn't work, error message: `No mode specified`.
  --       Workaround: Declare keymaps in the plugin config.
  --
  --   { '+t', '<Cmd>BufferLineCycleNext<CR>', desc = 'Next buffer' },
  --   { 'üt', '<Cmd>BufferLineCyclePrev<CR>', desc = 'Previous buffer' },
  -- },
  opts = function()
    local bufferline = require('bufferline')

    local icons = require('tigion.core.icons').diagnostics
    local mix_hex_colors = require('tigion.core.util').color.mix_hex_colors
    local fixed_highlights = require('tigion.core.util').bufferline.fixed_highlights

    local theme_colors = require('tokyonight.colors').setup({ style = 'moon' })
    local bg_default = theme_colors.bg_dark
    local bg_active = theme_colors.bg_highlight
    local bg_inactive = mix_hex_colors(bg_default, bg_active, 0.5)

    return {
      options = {
        mode = 'tabs', -- buffers (default), tabs (use only tabs as buffers)

        separator_style = 'slant', -- slant, slope, thick, thin (default), `{ 'any', 'any' }`
        style_preset = {
          bufferline.style_preset.no_italic,
          bufferline.style_preset.no_bold,
        },

        always_show_bufferline = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true,

        modified_icon = '',

        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(_, level, _, _)
          local icon = level:match('error') and icons.error
            or level:match('warn') and icons.warn
            or level:match('info') and icons.info
            or icons.hint
          return icon
        end,
      },

      -- Fixes highlights for theme with activated transparent background.
      highlights = fixed_highlights(bg_default, bg_inactive),

      -- highlights = vim.tbl_extend(
      --   'keep',
      --   {
      --     -- Place custom highlights here
      --   },
      --   -- Fixes highlights for theme with activated transparent background.
      --   fixed_highlights(bg_default, bg_inactive)
      -- ),
    }
  end,
  config = function(_, opts)
    require('bufferline').setup(opts)

    -- Add keymaps
    vim.keymap.set('n', '+t', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' })
    vim.keymap.set('n', 'üt', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })
  end,
}
