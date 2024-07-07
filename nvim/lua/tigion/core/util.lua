local M = {}

-- Converts the RGB values to a HEX string.
--
---@param r integer The red value in the range 0-255.
---@param g integer The green value in the range 0-255.
---@param b integer The blue value in the range 0-255.
---@return string # The hexadecimal value in the format #rrggbb.
function M.rgb_to_hex(r, g, b)
  r = math.max(0, math.min(255, r))
  g = math.max(0, math.min(255, g))
  b = math.max(0, math.min(255, b))
  return string.format('#%02x%02x%02x', r, g, b)
end

-- Converts the RGBA values to a HEX string.
--
---@param r integer The red value in the range 0-255.
---@param g integer The green value in the range 0-255.
---@param b integer The blue value in the range 0-255.
---@param a number The alpha value in the range 0-1.
---@return string # The hexadecimal value in the format #rrggbb.
function M.rgba_to_hex(r, g, b, a)
  r = math.max(0, math.min(255, r))
  g = math.max(0, math.min(255, g))
  b = math.max(0, math.min(255, b))
  a = math.max(0, math.min(1, a))
  return string.format('#%02x%02x%02x', r * a, g * a, b * a)
end

-- Converts the HSL values to a HEX string.
--
---@param h integer The hue value in degrees.
---@param s integer The saturation value in percent in the range 0-100.
---@param l integer The lightness value in percent in the range 0-100.
---@return string # The hexadecimal value in the format #rrggbb.
function M.hsl_to_hex(h, s, l)
  s = math.max(0, math.min(100, s))
  l = math.max(0, math.min(100, l))
  local r, g, b = M.hsl_to_rgb(h, s, l)
  return string.format('#%02x%02x%02x', r, g, b)
end

-- Converts the HSLA values to a HEX string.
--
---@param h integer The hue value in degrees.
---@param s integer The saturation value in percent in the range 0-100.
---@param l integer The lightness value in percent in the range 0-100.
---@param a number The alpha value in the range 0-1.
---@return string # The hexadecimal value in the format #rrggbb.
function M.hsla_to_hex(h, s, l, a)
  s = math.max(0, math.min(100, s))
  l = math.max(0, math.min(100, l))
  a = math.max(0, math.min(1, a))
  local r, g, b = M.hsl_to_rgb(h, s, l)
  return string.format('#%02x%02x%02x', r * a, g * a, b * a)
end

-- Converts CMYK values to a HEX string.
--
---@param c integer The cyan value in percent in the range 0-100.
---@param m integer The magenta value in percent in the range 0-100.
---@param y integer The yellow value in percent in the range 0-100.
---@param k integer The black value in percent in the range 0-100.
---@return string # The hexadecimal value in the format #rrggbb.
function M.cmyk_to_hex(c, m, y, k)
  c = math.max(0, math.min(100, c))
  m = math.max(0, math.min(100, m))
  y = math.max(0, math.min(100, y))
  k = math.max(0, math.min(100, k))
  c, m, y, k = c / 100, m / 100, y / 100, k / 100
  local r = 255 * (1 - c) * (1 - k)
  local g = 255 * (1 - m) * (1 - k)
  local b = 255 * (1 - y) * (1 - k)
  return string.format('#%02x%02x%02x', r, g, b)
end

-- Converts HSL values to RGB values.
-- https://www.w3.org/TR/css-color-3/#hsl-color
--
---@param h integer The hue value in degrees.
---@param s integer The saturation value in percent.
---@param l integer The lightness value in percent.
---@return integer, integer, integer
function M.hsl_to_rgb(h, s, l)
  h, s, l = h % 360, s / 100, l / 100
  if h < 0 then h = h + 360 end
  local function f(n)
    local k = (n + h / 30) % 12
    local a = s * math.min(l, 1 - l)
    return l - a * math.max(-1, math.min(k - 3, 9 - k, 1))
  end
  return f(0) * 255, f(8) * 255, f(4) * 255
end

return M
