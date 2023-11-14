return {
  'nvim-lualine/lualine.nvim',                      -- styled statusline
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional, for file icons
  config = function()
    local lualine = require('lualine')
    local icons = require('tigion.core.icons')

    lualine.setup {
      options = {
        icons_enabled = true,
        -- theme = 'solarized-osaka',
        theme = 'solarized_dark',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = {},
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { {
          'filename',
          file_status = true,
          path = 0,
        } },
        lualine_x = {
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = icons.diagnostics,
          },
          'encoding',
          'fileformat',
          'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { {
          'filename',
          file_status = true,
          path = 1,
        } },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'nvim-tree' },
    }
  end,
}