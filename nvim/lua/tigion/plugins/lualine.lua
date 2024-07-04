return {
  'nvim-lualine/lualine.nvim', -- styled statusline
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional, for file icons
  config = function()
    local lualine = require('lualine')
    local icons = require('tigion.core.icons')

    -- custom solarized-osaka section colors
    -- local so_colors = require('solarized-osaka.colors').setup({ transform = true })
    -- local custom_theme = require('lualine.themes.solarized-osaka')
    -- custom_theme.normal.b.fg = so_colors.black
    -- custom_theme.normal.b.bg = so_colors.fg

    -- get customized Codeium status
    local function getCodeiumStatus()
      if not pcall(vim.fn['codeium#Enabled']) then return '' end
      if not vim.fn['codeium#Enabled']() then return '' end

      local status = icons.codeium -- '󰘦'
      -- vim.api.nvim_call_function("codeium#GetStatusString", {})
      local str = string.gsub(vim.fn['codeium#GetStatusString'](), '%s+', '')
      if str ~= 'ON' and str ~= '' then status = status .. ' ' .. str end
      return status
    end

    lualine.setup({
      options = {
        icons_enabled = true,
        -- theme = 'solarized_dark',
        theme = 'solarized-osaka',
        -- theme = custom_theme,
        -- theme = 'tokyonight',
        section_separators = { left = '', right = '' },
        -- component_separators = { left = '', right = '' },
        component_separators = { left = '┊', right = '┊' },
        disabled_filetypes = {},
        -- globalstatus = false,
      },
      sections = {
        lualine_a = {
          {
            'mode',
            -- icon = icons.neovim,
          },
        },
        lualine_b = {
          { 'branch', icon = icons.git.branch },
        },
        lualine_c = {
          { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
          { 'filename', file_status = true, path = 0, padding = { left = 0, right = 1 } },
          {
            'diff',
            symbols = {
              added = icons.git.diff.added,
              modified = icons.git.diff.modified,
              removed = icons.git.diff.removed,
            },
          },
        },
        lualine_x = {
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = icons.diagnostics,
          },
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
          },
          { getCodeiumStatus },
          -- '%S󰘦 %3{codeium#GetStatusString()}',
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
        lualine_c = {
          { 'filename', file_status = true, path = 1 },
        },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'nvim-tree', 'trouble' },
    })
  end,
}
