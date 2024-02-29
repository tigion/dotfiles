return {
  'mhartington/formatter.nvim', -- format / indent (:Format)
  enabled = false,
  config = function()
    local status, formatter = pcall(require, 'formatter')
    if not status then return end

    -- Utilities for creating configurations
    local util = require('formatter.util')

    -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
    formatter.setup({
      logging = true, -- Enable or disable logging
      log_level = vim.log.levels.WARN, -- Set the log level
      -- All formatter configurations are opt-in
      filetype = {
        -- lua configuration
        lua = {
          -- defines default configurations
          require('formatter.filetypes.lua').stylua,
          -- define own configuration
          function()
            -- Supports conditional formatting
            if util.get_current_buffer_file_name() == 'special.lua' then return nil end
            -- files
            return {
              exe = 'stylua', -- need to be installed (`brew install stylua`)
              -- stylua: ignore
              args = {
                -- options (https://github.com/JohnnyMorganz/StyLua#options)
                --"--column-width", "90", -- (also relevant for `--collapse-simple-statement`)
                --"--indent-type", "Spaces", -- prefer spaces as indent type
                --"--indent-width", "2", -- use 2 characters as indent
                --'--quote-style', 'AutoPreferSingle', -- prefer single quote style
                --'--call-parentheses', 'None', -- omits parentheses on single string or table
                --'--collapse-simple-statement', 'Always', -- always collapse simple statements
                '--search-parent-directories',
                '--stdin-filepath', util.escape_path(util.get_current_buffer_file_path()),
                '--',
                '-',
              },
              stdin = true,
            }
          end,
        },

        -- any filetype configurations
        ['*'] = {
          -- defines default configurations
          require('formatter.filetypes.any').remove_trailing_whitespace,
        },
      },
    })
  end,
}

