return {
  'nvim-lualine/lualine.nvim',                      -- styled statusline
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional, for file icons
  config = function()
    local lualine = require('lualine')
    local icons = require('tigion.core.icons')

    -- get customized Codeium status
    local function getCodeiumStatus()
      if not pcall(vim.fn['codeium#Enabled']) then return '' end
      if not vim.fn['codeium#Enabled']() then return '' end

      local status = '󰘦'
      -- vim.api.nvim_call_function("codeium#GetStatusString", {})
      local str = string.gsub(vim.fn['codeium#GetStatusString'](), '%s+', '')
      if str ~= 'ON' and str ~= '' then
        status = status .. ' ' .. str
      end
      return status
    end

    lualine.setup {
      options = {
        icons_enabled = true,
        theme = 'solarized-osaka',
        -- theme = 'solarized_dark',
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