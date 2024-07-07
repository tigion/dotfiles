return {
  'echasnovski/mini.hipatterns',
  enabled = true,
  version = false,
  opts = {},
  config = function(_, opts)
    require('mini.hipatterns').setup(opts)

    local hipatterns = require('mini.hipatterns')

    -- Returns hex color group for matching short hex color.
    --
    ---@param match string
    ---@return string
    local hex_color_short = function(_, match)
      local style = 'fg' -- 'fg' or 'bg', for extmark_opts_inline use 'fg'
      local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
      local hex = string.format('#%s%s%s%s%s%s', r, r, g, g, b, b)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns hex color group for matching rgb() color.
    --
    ---@param match string
    ---@return string
    local rgb_color = function(_, match)
      local style = 'fg' -- 'fg' or 'bg', for extmark_opts_inline use 'fg'
      local red, green, blue = match:match('rgb%((%d+), ?(%d+), ?(%d+)%)')
      local hex = string.format('#%02x%02x%02x', red, green, blue)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns hex color group for matching rgba() color
    -- or false if alpha is nil or out of range.
    -- The use of the alpha value refers to a black background.
    --
    ---@param match string
    ---@return string|false
    local rgba_color = function(_, match)
      local style = 'fg' -- 'fg' or 'bg', for extmark_opts_inline use 'fg'
      local red, green, blue, alpha = match:match('rgba%((%d+), ?(%d+), ?(%d+), ?(%d*%.?%d*)%)')
      alpha = tonumber(alpha)
      if alpha == nil or alpha < 0 or alpha > 1 then return false end
      local hex = string.format('#%02x%02x%02x', red * alpha, green * alpha, blue * alpha)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns hex color group for matching hsl() color.
    --
    ---@param match string
    ---@return string, integer, integer, integer
    local hsl_color = function(_, match)
      local style = 'fg' -- 'fg' or 'bg', for extmark_opts_inline use 'fg'
      local hue, saturation, lightness = match:match('hsl%((%d+), ?(%d+)%%, ?(%d+)%%%)')

      -- Converts HSL to RGB.
      -- https://www.w3.org/TR/css-color-3/#hsl-color
      --
      ---@param h string The hue value in degrees.
      ---@param s string The saturation value in percent.
      ---@param l string The lightness value in percent.
      ---@return integer, integer, integer
      local function hsl_to_rgb(h, s, l)
        h, s, l = h % 360, s / 100, l / 100
        if h < 0 then h = h + 360 end
        local function f(n)
          local k = (n + h / 30) % 12
          local a = s * math.min(l, 1 - l)
          return l - a * math.max(-1, math.min(k - 3, 9 - k, 1))
        end
        return f(0) * 255, f(8) * 255, f(4) * 255
      end

      local red, green, blue = hsl_to_rgb(hue, saturation, lightness)
      local hex = string.format('#%02x%02x%02x', red, green, blue)
      return hipatterns.compute_hex_color_group(hex, style), red, green, blue
    end

    -- Returns hex color group for matching hsla() color
    -- or false if alpha is nil or out of range.
    -- The use of the alpha value refers to a black background.
    --
    ---@param match string
    ---@return string|false
    local hsla_color = function(_, match)
      local style = 'fg' -- 'fg' or 'bg', for extmark_opts_inline use 'fg'
      local hue, saturation, lightness, alpha = match:match('hsla%((%d+), ?(%d+)%%, ?(%d+)%%, ?(%d*%.?%d*)%)')
      alpha = tonumber(alpha)
      if alpha == nil or alpha < 0 or alpha > 1 then return false end
      local _, red, green, blue = hsl_color(_, string.format('hsl(%s, %s%%, %s%%)', hue, saturation, lightness))
      local hex = string.format('#%02x%02x%02x', red * alpha, green * alpha, blue * alpha)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns hex color group for matching cmyk() color.
    --
    ---@param match string
    ---@return string
    local cmyk_color = function(_, match)
      local style = 'fg' -- 'fg' or 'bg', for extmark_opts_inline use 'fg'
      local cyan, magenta, yellow, black = match:match('cmyk%((%d+)%%, ?(%d+)%%, ?(%d+)%%, ?(%d+)%%%)')
      cyan, magenta, yellow, black = cyan / 100, magenta / 100, yellow / 100, black / 100
      local red = 255 * (1 - cyan) * (1 - black)
      local green = 255 * (1 - magenta) * (1 - black)
      local blue = 255 * (1 - yellow) * (1 - black)
      local hex = string.format('#%02x%02x%02x', red, green, blue)
      return hipatterns.compute_hex_color_group(hex, style)
    end

    -- Returns extmark opts for highlights with virtual inline text.
    --
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

    hipatterns.setup({
      highlighters = {
        -- `#rrggbb`
        -- hex_color = hipatterns.gen_highlighter.hex_color({ style = 'full' }),
        hex_color = hipatterns.gen_highlighter.hex_color({ style = 'inline', inline_text = ' ' }),

        -- `#rgb`
        hex_color_short = { pattern = '#%x%x%x%f[%X]', group = hex_color_short, extmark_opts = extmark_opts_inline },

        -- `rgb(255, 255, 255)`
        rgb_color = { pattern = 'rgb%(%d+, ?%d+, ?%d+%)', group = rgb_color, extmark_opts = extmark_opts_inline },

        -- `rgba(255, 255, 255, 0.5)`
        rgba_color = {
          pattern = 'rgba%(%d+, ?%d+, ?%d+, ?%d*%.?%d*%)',
          group = rgba_color,
          extmark_opts = extmark_opts_inline,
        },

        -- `hsl(0, 100%, 50%)`
        hsl_color = {
          pattern = 'hsl%(%d+, ?%d+%%, ?%d+%%%)',
          group = hsl_color,
          extmark_opts = extmark_opts_inline,
        },

        -- `hsla(0, 100%, 50%, 0.5)`
        hsla_color = {
          pattern = 'hsla%(%d+, ?%d+%%, ?%d+%%, ?%d*%.?%d*%)',
          group = hsla_color,
          extmark_opts = extmark_opts_inline,
        },

        -- `cmyk(100%, 0%, 0%, 0%)`
        cmyk_color = {
          pattern = 'cmyk%(%d+%%, ?%d+%%, ?%d+%%, ?%d+%%%)',
          group = cmyk_color,
          extmark_opts = extmark_opts_inline,
        },
      },
    })
  end,
}
