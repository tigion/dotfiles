return {
  'akinsho/bufferline.nvim', -- styled tabs
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional, for file icons
  version = '*',
  config = function()
    local bufferline = require('bufferline')

    local icons = require('tigion.core.icons').diagnostics

    local theme_colors = require('tokyonight.colors').setup({ style = 'moon' })
    local bg_default = theme_colors.bg_dark --'#1e2030'
    local bg_inactive = '#272b3f' -- between bg_highlight and bg
    local bg_active = nil --theme_colors.bg_highlight --'#2f334d'

    local fill_bg = bg_default
    local tab_bg = bg_inactive
    local tab_selected_bg = bg_active
    local buffer_bg = bg_inactive
    local buffer_visible_bg = bg_active
    local buffer_selected_bg = bg_active

    bufferline.setup({
      options = {
        mode = 'tabs', -- tabs, buffers

        separator_style = 'slant',
        style_preset = {
          bufferline.style_preset.no_italic,
          bufferline.style_preset.no_bold,
        },

        always_show_bufferline = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true,

        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(_, level, _, _)
          local icon = level:match('error') and icons.error
            or level:match('warn') and icons.warn
            or level:match('info') and icons.info
            or icons.hint
          return icon
        end,
      },

      -- Overwrite highlights for theme with transparent background
      highlights = {
        -- Base highlights
        fill = { bg = fill_bg }, -- Bufferline background

        -- Tab highlights
        tab = { bg = tab_bg },
        tab_selected = { bg = tab_selected_bg },
        tab_separator = { fg = fill_bg, bg = tab_bg },
        tab_separator_selected = { fg = fill_bg, bg = tab_selected_bg },
        tab_close = { bg = fill_bg },

        -- Buffer highlights
        background = { bg = buffer_bg },

        buffer_visible = { bg = buffer_visible_bg },
        buffer_selected = { bg = buffer_selected_bg },

        close_button = { bg = buffer_bg },
        close_button_visible = { bg = buffer_visible_bg },
        close_button_selected = { bg = buffer_selected_bg },

        indicator_visible = { fg = fill_bg, bg = buffer_visible_bg },
        indicator_selected = { fg = fill_bg, bg = buffer_selected_bg }, -- BUG: Does not work with theme transparency in mode 'thin' for indicator icon!

        separator = { fg = fill_bg, bg = buffer_bg },
        separator_visible = { fg = fill_bg, bg = buffer_visible_bg },
        separator_selected = { fg = fill_bg, bg = buffer_selected_bg },

        modified = { bg = buffer_bg },
        modified_visible = { bg = buffer_visible_bg },
        modified_selected = { bg = buffer_selected_bg },

        duplicate = { bg = buffer_bg },
        duplicate_visible = { bg = buffer_visible_bg },
        duplicate_selected = { bg = buffer_selected_bg },

        diagnostic = { bg = buffer_bg },
        diagnostic_visible = { bg = buffer_visible_bg },
        diagnostic_selected = { bg = buffer_selected_bg },

        error = { bg = buffer_bg },
        error_visible = { bg = buffer_visible_bg },
        error_selected = { bg = buffer_selected_bg },
        warning = { bg = buffer_bg },
        warning_visible = { bg = buffer_visible_bg },
        warning_selected = { bg = buffer_selected_bg },
        info = { bg = buffer_bg },
        info_visible = { bg = buffer_visible_bg },
        info_selected = { bg = buffer_selected_bg },
        hint = { bg = buffer_bg },
        hint_visible = { bg = buffer_visible_bg },
        hint_selected = { bg = buffer_selected_bg },

        error_diagnostic = { bg = buffer_bg },
        error_diagnostic_visible = { bg = buffer_visible_bg },
        error_diagnostic_selected = { bg = buffer_selected_bg },
        warning_diagnostic = { bg = buffer_bg },
        warning_diagnostic_visible = { bg = buffer_visible_bg },
        warning_diagnostic_selected = { bg = buffer_selected_bg },
        info_diagnostic = { bg = buffer_bg },
        info_diagnostic_visible = { bg = buffer_visible_bg },
        info_diagnostic_selected = { bg = buffer_selected_bg },
        hint_diagnostic = { bg = buffer_bg },
        hint_diagnostic_visible = { bg = buffer_visible_bg },
        hint_diagnostic_selected = { bg = buffer_selected_bg },
      },
    })

    vim.keymap.set('n', '+t', '<Cmd>BufferLineCycleNext<CR>', {})
    vim.keymap.set('n', 'üt', '<Cmd>BufferLineCyclePrev<CR>', {})
  end,
}
