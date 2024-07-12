return {
  'echasnovski/mini.hipatterns',
  enabled = true,
  version = false,
  event = 'VeryLazy',
  keys = {
    { '<leader>th', '<cmd>lua require("mini.hipatterns").toggle()<cr>', desc = 'Toggle hipatterns' },
  },
  opts = {},
  config = function(_, opts)
    require('mini.hipatterns').setup(opts)

    local hipatterns = require('mini.hipatterns')

    local rgb_to_hex = require('tigion.core.util').color.rgb_to_hex
    local rgba_to_hex = require('tigion.core.util').color.rgba_to_hex
    local hsl_to_hex = require('tigion.core.util').color.hsl_to_hex
    local hsla_to_hex = require('tigion.core.util').color.hsla_to_hex
    local cmyk_to_hex = require('tigion.core.util').color.cmyk_to_hex

    -- Table with my styles and the corresponding group style in `MiniHipatterns.compute_hex_color_group`
    local hi_group_styles = { fg = 'fg', bg = 'bg', line = 'line', inline = 'fg' }
    -- The global style for my custom highlights
    local my_style = 'inline' -- 'fg', 'bg', 'line' or 'inline'

    -- Returns hex color group for matching short hex color.
    ---@param match string
    ---@return string
    local hex_color_short = function(_, match)
      local style = hi_group_styles[my_style] or 'bg' -- 'fg', 'bg' or 'line'
      local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
      local hex = string.format('#%s%s%s%s%s%s', r, r, g, g, b, b)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns hex color group for matching rgb() color.
    ---@param match string
    ---@return string
    local rgb_color = function(_, match)
      local style = hi_group_styles[my_style] or 'bg' -- 'fg', 'bg' or 'line'
      local r, g, b = match:match('rgb%((%d+), ?(%d+), ?(%d+)%)')
      local hex = rgb_to_hex(r, g, b)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns hex color group for matching rgba() color or false if alpha is nil.
    -- The use of the alpha value refers to a black background.
    ---@param match string
    ---@return string|false
    local rgba_color = function(_, match)
      local style = hi_group_styles[my_style] or 'bg' -- 'fg', 'bg' or 'line'
      local r, g, b, a = match:match('rgba%((%d+), ?(%d+), ?(%d+), ?(%d*%.?%d*)%)')
      a = tonumber(a)
      if a == nil then return false end
      local hex = rgba_to_hex(r, g, b, a)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns hex color group for matching hsl() color.
    ---@param match string
    ---@return string --, integer, integer, integer
    local hsl_color = function(_, match)
      local style = hi_group_styles[my_style] or 'bg' -- 'fg', 'bg' or 'line'
      local h, s, l = match:match('hsl%((%d+), ?(%d+)%%, ?(%d+)%%%)')
      local hex = hsl_to_hex(h, s, l)
      return hipatterns.compute_hex_color_group(hex, style) --, red, green, blue
    end

    -- Returns hex color group for matching hsla() color or false if alpha is nil.
    -- The use of the alpha value refers to a black background.
    ---@param match string
    ---@return string|false
    local hsla_color = function(_, match)
      local style = hi_group_styles[my_style] or 'bg' -- 'fg', 'bg' or 'line'
      local h, s, l, a = match:match('hsla%((%d+), ?(%d+)%%, ?(%d+)%%, ?(%d*%.?%d*)%)')
      a = tonumber(a)
      if a == nil then return false end
      local hex = hsla_to_hex(h, s, l, a)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns hex color group for matching cmyk() color.
    ---@param match string
    ---@return string
    local cmyk_color = function(_, match)
      local style = hi_group_styles[my_style] or 'bg' -- 'fg', 'bg' or 'line'
      local c, m, y, k = match:match('cmyk%((%d+)%%, ?(%d+)%%, ?(%d+)%%, ?(%d+)%%%)')
      local hex = cmyk_to_hex(c, m, y, k)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns extmark opts for highlights with virtual inline text.
    ---@param data table Includes `hl_group`, `full_match` and more.
    ---@return table
    local extmark_opts_inline = function(_, _, data)
      return {
        virt_text = { { ' ', data.hl_group } },
        virt_text_pos = 'inline',
        -- priority = 200,
        right_gravity = false,
      }
    end

    -- For my style `inline` use extra extmark opts.
    local my_extmark_opts = my_style == 'inline' and extmark_opts_inline or nil

    hipatterns.setup({
      highlighters = {
        -- `#ff0000`
        -- hex_color = hipatterns.gen_highlighter.hex_color({ style = 'full' }),
        hex_color = hipatterns.gen_highlighter.hex_color({ style = 'inline', inline_text = ' ' }),

        -- `#f00`
        -- Checks:
        -- - true: #0f0 '#0f0'  "#0f0" #0f0 :#0f0 (#0f0)
        -- - false: #f #f0 #f000 #f0000 #f00tor (like #factor) #facc #f00ö (like #dafür)
        -- - Allow? #ff0#ff0
        hex_color_short = {
          -- pattern = '#%x%x%x%f[%X]', -- ! `#f00tor`, `#f00ö`
          -- pattern = '()#%x%x%x()%f[^%x%w]', -- ! match `#f00ö`
          pattern = '#%x%x%x%f[%p%s%c%z]',
          group = hex_color_short,
          extmark_opts = my_extmark_opts,
        },

        -- `rgb(255, 0, 0)`
        rgb_color = { pattern = 'rgb%(%d+, ?%d+, ?%d+%)', group = rgb_color, extmark_opts = my_extmark_opts },

        -- `rgba(255, 0, 0, 0.5)`
        rgba_color = {
          pattern = 'rgba%(%d+, ?%d+, ?%d+, ?%d*%.?%d*%)',
          group = rgba_color,
          extmark_opts = my_extmark_opts,
        },

        -- `hsl(0, 100%, 50%)`
        hsl_color = {
          pattern = 'hsl%(%d+, ?%d+%%, ?%d+%%%)',
          group = hsl_color,
          extmark_opts = my_extmark_opts,
        },

        -- `hsla(0, 100%, 50%, 0.5)`
        hsla_color = {
          pattern = 'hsla%(%d+, ?%d+%%, ?%d+%%, ?%d*%.?%d*%)',
          group = hsla_color,
          extmark_opts = my_extmark_opts,
        },

        -- `cmyk(0%, 100%, 100%, 0%)`
        cmyk_color = {
          pattern = 'cmyk%(%d+%%, ?%d+%%, ?%d+%%, ?%d+%%%)',
          group = cmyk_color,
          extmark_opts = my_extmark_opts,
        },
      },
    })
  end,
}
