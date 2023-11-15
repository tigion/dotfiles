return {
  'svrana/neosolarized.nvim',                     -- truecolor, solarized dark color
  enabled = false,
  dependencies = { 'tjdevries/colorbuddy.nvim' }, -- colorscheme helper
  lazy = false,                                   -- make sure we load this during startup if it is your main colorscheme
  priority = 1000,                                -- make sure to load this before all the other start plugins
  config = function()
    local neosolarized = require('neosolarized')

    neosolarized.setup {
      comment_italics = true,
      background_set = false,
    }

    local cb = require 'colorbuddy.init'
    local Color = cb.Color
    local colors = cb.colors
    local Group = cb.Group
    local groups = cb.groups
    local styles = cb.styles

    --[[
    Color.new("base03",  "#002b36")
    Color.new("base02",  "#073642")
    Color.new("base01",  "#586e75")
    Color.new("base00",  "#657b83")
    Color.new("base0",   "#839496")
    Color.new("base1",   "#93a1a1")
    Color.new("base2",   "#eee8d5")
    Color.new("base3",   "#fdf6e3")
    Color.new("yellow",  "#b58900")
    Color.new("orange",  "#cb4b16")
    Color.new("red",     "#dc322f")
    Color.new("magenta", "#d33682")
    Color.new("violet",  "#6c71c4")
    Color.new("blue",    "#268bd2")
    Color.new("cyan",    "#2aa198")
    Color.new("green",   "#719e07")
    ]]

    -- ...
    Color.new('black', '#000000')
    Group.new('CursorLine', colors.none, colors.base03, styles.NONE, colors.base1)
    Group.new('CursorLine2', colors.none, colors.base02, styles.NONE, colors.base1)
    Group.new('CursorLineNr', colors.yellow, colors.black, styles.NONE, colors.base1)
    Group.new('Visual', colors.none, colors.base03, styles.reverse)

    -- Diagnostics
    local cError = groups.Error.fg
    local cInfo = groups.Information.fg
    local cWarn = groups.Warning.fg
    local cHint = groups.Hint.fg

    Group.new('DiagnosticVirtualTextError', cError, cError:dark():dark():dark():dark(), styles.NONE)
    Group.new('DiagnosticVirtualTextInfo', cInfo, cInfo:dark():dark():dark(), styles.NONE)
    Group.new('DiagnosticVirtualTextWarn', cWarn, cWarn:dark():dark():dark(), styles.NONE)
    Group.new('DiagnosticVirtualTextHint', cHint, cHint:dark():dark():dark(), styles.NONE)
    Group.new('DiagnosticUnderlineError', colors.none, colors.none, styles.undercurl, cError)
    Group.new('DiagnosticUnderlineWarn', colors.none, colors.none, styles.undercurl, cWarn)
    Group.new('DiagnosticUnderlineInfo', colors.none, colors.none, styles.undercurl, cInfo)
    Group.new('DiagnosticUnderlineHint', colors.none, colors.none, styles.undercurl, cHint)

    Group.new('FloatBorder', colors.base01, groups.FloatBorder.bg)
    -- Group.new('NormalFloat', groups.NormalFloat.fg, colors.base02)

    -- alpha-nvim
    Group.new('AlphaHeader', colors.orange)
    Group.new('AlphaButtons', colors.blue)
    Group.new('AlphaShortCut', colors.green)
    Group.new('AlphaFooter', colors.base01:dark())

    -- indent-blankline
    Group.new('IblIndent', colors.base01:dark():dark(), nil, styles.nocombine)
    Group.new('IblScope', groups.Label.fg:dark(), nil, styles.nocombine)
    Group.new('IblWhitespace', nil, nil, styles.nocombine)
    -- Group.new('IblIndentContext', colors.yellow:dark(), nil, styles.nocombine) -- Dont exist in current v3

    -- load the colorscheme here
    vim.cmd [[colorscheme neosolarized]]
  end,
}