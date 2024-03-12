return {
  'hedyhli/outline.nvim',
  keys = { { '<Leader>o', '<Cmd>Outline<CR>', desc = 'Toggle outline of symbols' } },
  cmd = 'Outline',
  opts = function()
    local opts = {
      outline_window = {
        width = 28,
        relative_width = false,
        -- focus_on_open = true,
      },
      symbol_folding = {
        -- markers = { '', '' },
      },
      symbols = {
        icons = {},
      },
    }
    local defaults = require('outline.config').defaults
    local icons = require('tigion.core.icons')
    for kind, symbol in pairs(defaults.symbols.icons) do
      opts.symbols.icons[kind] = {
        icon = icons.code[kind] or symbol.icon,
        hl = symbol.hl,
      }
    end

    return opts
  end,
}
