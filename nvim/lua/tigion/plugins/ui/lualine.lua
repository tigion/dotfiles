return {
  'nvim-lualine/lualine.nvim', -- styled statusline
  dependencies = { 'echasnovski/mini.icons' }, -- optional, for file icons
  -- dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional, for file icons
  config = function()
    local lualine = require('lualine')
    local icons = require('tigion.core.icons')

    -- custom solarized-osaka section colors
    -- local so_colors = require('solarized-osaka.colors').setup({ transform = true })
    -- local custom_theme = require('lualine.themes.solarized-osaka')
    -- custom_theme.normal.b.fg = so_colors.blue
    -- custom_theme.normal.b.bg = so_colors.base02
    -- custom_theme.normal.c.bg = so_colors.base04
    -- custom_theme.insert['b'] = { bg = custom_theme.normal.b.bg, fg = custom_theme.insert.a.bg }
    -- custom_theme.command['b'] = { bg = custom_theme.normal.b.bg, fg = custom_theme.command.a.bg }
    -- custom_theme.visual['b'] = { bg = custom_theme.normal.b.bg, fg = custom_theme.visual.a.bg }
    -- custom_theme.replace['b'] = { bg = custom_theme.normal.b.bg, fg = custom_theme.replace.a.bg }
    -- custom_theme.terminal['b'] = { bg = custom_theme.normal.b.bg, fg = custom_theme.terminal.a.bg }

    lualine.setup({
      options = {
        icons_enabled = true,
        -- theme = 'solarized_dark',
        -- theme = 'solarized-osaka',
        -- theme = custom_theme,
        theme = 'tokyonight',
        -- theme = 'catppuccin',
        -- theme = 'onedark',
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
            symbols = icons.diagnostic.signs,
            on_click = function() vim.cmd('Trouble diagnostics toggle') end,
          },
          {
            require('tigion.core.util').info.spell,
            separator = '',
            padding = { left = 1, right = 0 },
            on_click = function() print('Spell languages: ' .. table.concat(vim.opt.spelllang:get(), ', ')) end,
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
          { require('tigion.core.util').supermaven.status },
          { require('tigion.core.util').codeium.status },
          -- '%S󰘦 %3{codeium#GetStatusString()}',
          {
            require('tigion.core.util').info.lsp,
            -- separator = '',
            -- padding = { left = 1, right = 0 },
            on_click = function() print('LSP servers: ' .. require('tigion.core.util').info.lsp_servers()) end,
          },
          -- {
          --   require('tigion.core.util').info.lsp_servers,
          --   color = { fg = '#545c7e', gui = 'italic' },
          --   on_click = function() vim.cmd('LspInfo') end,
          -- },
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
