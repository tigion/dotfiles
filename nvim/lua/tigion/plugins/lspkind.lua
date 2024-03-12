return {
  'onsails/lspkind-nvim', -- vscode-like pictograms
  config = function()
    local status, lspkind = pcall(require, 'lspkind')
    if not status then return end

    local icons = require('tigion.core.icons')

    local symbol_map = {}
    for kind, icon in pairs(icons.code) do
      symbol_map[kind] = icon
    end

    lspkind.init({
      -- enables text annotations

      -- defines how annotations are shown
      -- default: symbol
      -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
      mode = 'symbol_text',

      -- default symbol map
      -- can be either 'default' (requires nerd-fonts font) or
      -- 'codicons' for codicon preset (requires vscode-codicons font)
      --
      -- default: 'default'
      preset = 'codicons',

      -- override preset symbols
      --
      -- default: {}
      symbol_map = symbol_map,
    })
  end,
}
