return {
  -- This plugin adds a fast and easy to configure statusline to Neovim.
  -- Link: https://github.com/nvim-lualine/lualine.nvim

  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-mini/mini.icons' },
  config = function()
    local lualine = require('lualine')
    local icons = require('tigion.core.icons')

    lualine.setup({
      options = {
        icons_enabled = true,
        theme = 'tokyonight',
        -- theme = 'catppuccin',
        -- theme = 'onedark',
        -- section_separators = { left = '', right = '' },
        section_separators = { left = '▌', right = '▐' },
        -- section_separators = { left = '', right = '' },
        -- component_separators = { left = '', right = '' },
        -- component_separators = { left = '┊', right = '┊' },
        component_separators = { left = '', right = '' },
        -- component_separators = { left = '', right = '' },
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
          {
            require('tigion.core.util').info.dir_path,
            separator = '',
            padding = { left = 1, right = 0 },
            icon = icons.folder.closed,
          },
          { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
          {
            'filename',
            file_status = true,
            path = 0,
            padding = { left = 0, right = 1 },
            -- color = function() return vim.bo.modified and { fg = 'fg' } end,
          },
          -- { 'filename', file_status = true, path = 1, shorting_target = 85, padding = { left = 0, right = 1 } },
          -- { 'filename', file_status = true, path = 4, padding = { left = 0, right = 1 } },
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
            symbols = icons.diagnostic.signs,
            on_click = function() vim.cmd('Trouble diagnostics toggle') end,
          },
          {
            require('tigion.core.util').info.spell,
            separator = '',
            padding = { left = 1, right = 0 },
            on_click = function() vim.notify('Spell languages: ' .. table.concat(vim.opt.spelllang:get(), ', ')) end,
          },
          {
            require('tigion.core.util').info.spell_languages,
            color = { fg = '#545c7e', gui = 'italic' },
          },
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            on_click = function() vim.cmd('Lazy') end,
          },
          {
            require('tigion.core.util').copilot.status,
            color = require('tigion.core.util').copilot.color,
            cond = require('tigion.core.util').copilot.condition,
          },
          {
            require('tigion.core.util').info.lsp,
            on_click = function() vim.notify('LSP servers: ' .. require('tigion.core.util').info.lsp_servers()) end,
          },
          {
            'encoding',
            fmt = function(str) return (str ~= 'utf-8') and str or '' end,
          },
          {
            'fileformat',
            fmt = function(str) return (str ~= '') and str or '' end,
          },
          'filetype',
        },
        lualine_y = {
          {
            'progress',
            icon = '',
          },
        },
        lualine_z = {
          {
            'location',
            fmt = function(str) return vim.trim(str) end,
          },
        },
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
