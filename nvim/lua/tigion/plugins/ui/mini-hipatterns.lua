return {
  -- This plugin highlight patterns in text in Neovim.
  -- Link: https://github.com/echasnovski/mini.hipatterns

  'echasnovski/mini.hipatterns',
  enabled = true,
  version = false,
  event = 'VeryLazy',
  keys = {
    { '<leader>thi', '<cmd>lua require("mini.hipatterns").toggle()<cr>', desc = 'Toggle mini.hipatterns' },
  },
  opts = {},
  config = function(_, opts)
    require('mini.hipatterns').setup(opts)

    local hipatterns = require('mini.hipatterns')
    local util_color = require('tigion.core.util').color

    -- Table with my styles and the corresponding group style in `MiniHipatterns.compute_hex_color_group`
    local hi_group_styles = { fg = 'fg', bg = 'bg', line = 'line', full = 'bg', inline = 'fg' }
    -- The global style for my custom color pattern highlights
    local my_style = 'inline'
    local my_inline_text = ' ' --  󱓻  󰝤

    -- Returns hex color group for matching hex color.
    ---@param match string
    ---@return string
    local hex_color_group = function(_, match)
      local style = hi_group_styles[my_style] or 'bg'
      local r, g, b = match:sub(2, 3), match:sub(4, 5), match:sub(6, 7)
      local hex = string.format('#%s%s%s', r, g, b)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns hex color group for matching short hex color.
    ---@param match string
    ---@return string
    local hex_color_short_group = function(_, match)
      local style = hi_group_styles[my_style] or 'bg'
      local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
      local hex = string.format('#%s%s%s%s%s%s', r, r, g, g, b, b)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns hex color group for matching rgb() color.
    ---@param match string
    ---@return string
    local rgb_color_group = function(_, match)
      local style = hi_group_styles[my_style] or 'bg'
      local r, g, b = match:match('rgb%((%d+), ?(%d+), ?(%d+)%)')
      local hex = util_color.rgb_to_hex(r, g, b)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns hex color group for matching rgba() color or false if alpha is nil.
    -- The use of the alpha value refers to a black background.
    ---@param match string
    ---@return string|false
    local rgba_color_group = function(_, match)
      local style = hi_group_styles[my_style] or 'bg'
      local r, g, b, a = match:match('rgba%((%d+), ?(%d+), ?(%d+), ?(%d*%.?%d*)%)')
      a = tonumber(a)
      if a == nil then return false end
      local hex = util_color.rgba_to_hex(r, g, b, a)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns hex color group for matching hsl() color.
    ---@param match string
    ---@return string --, integer, integer, integer
    local hsl_color_group = function(_, match)
      local style = hi_group_styles[my_style] or 'bg'
      local h, s, l = match:match('hsl%((%d+), ?(%d+)%%, ?(%d+)%%%)')
      local hex = util_color.hsl_to_hex(h, s, l)
      return hipatterns.compute_hex_color_group(hex, style) --, red, green, blue
    end

    -- Returns hex color group for matching hsla() color or false if alpha is nil.
    -- The use of the alpha value refers to a black background.
    ---@param match string
    ---@return string|false
    local hsla_color_group = function(_, match)
      local style = hi_group_styles[my_style] or 'bg'
      local h, s, l, a = match:match('hsla%((%d+), ?(%d+)%%, ?(%d+)%%, ?(%d*%.?%d*)%)')
      a = tonumber(a)
      if a == nil then return false end
      local hex = util_color.hsla_to_hex(h, s, l, a)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns hex color group for matching cmyk() color.
    ---@param match string
    ---@return string
    local cmyk_color_group = function(_, match)
      local style = hi_group_styles[my_style] or 'bg'
      local c, m, y, k = match:match('cmyk%((%d+)%%, ?(%d+)%%, ?(%d+)%%, ?(%d+)%%%)')
      local hex = util_color.cmyk_to_hex(c, m, y, k)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns extmark opts for highlights with virtual inline text.
    ---@param data table Includes `hl_group`, `full_match` and more.
    ---@return table
    local extmark_opts_inline = function(_, _, data)
      return {
        virt_text = { { my_inline_text, data.hl_group } },
        virt_text_pos = 'inline',
        priority = 200,
        right_gravity = false,
      }
    end

    -- For my style `inline` use extra extmark opts.
    local my_extmark_opts = my_style == 'inline' and extmark_opts_inline or nil

    hipatterns.setup({
      highlighters = {
        -- `#00ff00`
        -- hex_color = hipatterns.gen_highlighter.hex_color({ style = 'full' }),
        -- hex_color = hipatterns.gen_highlighter.hex_color({ style = 'inline', inline_text = ' ' }),

        -- True:  #00ff00 '#00ff00' "#00ff00" :#00ff00 (#00ff00) #ffff00#ffff00
        -- False: #f #ff #ff00 #ff000 #ff0000tor #ff0000ö
        hex_color = {
          pattern = '#%x%x%x%x%x%x%f[%p%s%c%z]',
          group = hex_color_group,
          extmark_opts = my_extmark_opts,
        },

        -- True:  #0f0 '#0f0' "#0f0" :#0f0 (#0f0) #ff0#ff0
        -- False: #f #f0 #f000 #f0000 #f00tor (like #factor) #facc #f00ö (like #dafür)
        hex_color_short = {
          -- pattern = '#%x%x%x%f[%X]', -- ! `#f00tor`, `#f00ö`
          -- pattern = '()#%x%x%x()%f[^%x%w]', -- ! match `#f00ö`
          pattern = '#%x%x%x%f[%p%s%c%z]',
          group = hex_color_short_group,
          extmark_opts = my_extmark_opts,
        },

        -- `rgb(0, 255, 0)`
        rgb_color = { pattern = 'rgb%(%d+, ?%d+, ?%d+%)', group = rgb_color_group, extmark_opts = my_extmark_opts },

        -- `rgba(0, 255, 0, 0.5)`
        rgba_color = {
          pattern = 'rgba%(%d+, ?%d+, ?%d+, ?%d*%.?%d*%)',
          group = rgba_color_group,
          extmark_opts = my_extmark_opts,
        },

        -- `hsl(100, 100%, 50%)`
        hsl_color = {
          pattern = 'hsl%(%d+, ?%d+%%, ?%d+%%%)',
          group = hsl_color_group,
          extmark_opts = my_extmark_opts,
        },

        -- `hsla(100, 100%, 50%, 0.5)`
        hsla_color = {
          pattern = 'hsla%(%d+, ?%d+%%, ?%d+%%, ?%d*%.?%d*%)',
          group = hsla_color_group,
          extmark_opts = my_extmark_opts,
        },

        -- `cmyk(100%, 0%, 100%, 0%)`
        -- `cmyk(100%, 0%, 100%, 50%)`
        cmyk_color = {
          pattern = 'cmyk%(%d+%%, ?%d+%%, ?%d+%%, ?%d+%%%)',
          group = cmyk_color_group,
          extmark_opts = my_extmark_opts,
        },
      },
    })
  end,
}
