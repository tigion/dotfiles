local M = {}

M.info = {}

---Returns the Neovim version as formatted string.
---@return string
function M.info.nvim_version()
  local version = vim.version()
  local v = 'v' .. version.major .. '.' .. version.minor .. '.' .. version.patch
  -- if version.prerelease ~= nil then v = v .. '-' .. version.prerelease end
  return v
end

---Returns the number of used plugins (lazy.nvim).
---@return number
function M.info.plugin_count()
  -- local plugin_count = vim.fn.len(vim.fn.globpath(vim.fn.stdpath('data') .. '/lazy', '*', false, 1))
  local plugin_count = require('lazy').stats().count
  return plugin_count
end

M.color = {}

---Limits a value between min and max.
---@param value number
---@param min number
---@param max number
---@return number
local function limit(value, min, max) return math.min(math.max(value, min), max) end

---Limits a value between 0 and 255.
---@param value number
---@return number
local function limit_rgb(value) return limit(value, 0, 255) end

---Limits a value between 0 and 100.
---@param value number
---@return number
local function limit_percent(value) return limit(value, 0, 100) end

---Limits a value between 0 and 1.
---@param value number
---@return number
local function limit_alpha(value) return limit(value, 0, 1) end

---Converts HSL values to RGB values.
-- https://www.w3.org/TR/css-color-3/#hsl-color
---@param h integer The hue value in degrees.
---@param s integer The saturation value in percent.
---@param l integer The lightness value in percent.
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

---Converts the RGB values to a HEX string.
---@param r integer The red value.
---@param g integer The green value.
---@param b integer The blue value.
---@return string # The hexadecimal value in the format #rrggbb.
function M.color.rgb_to_hex(r, g, b)
  r, g, b = limit_rgb(r), limit_rgb(g), limit_rgb(b)
  return string.format('#%02x%02x%02x', r, g, b)
end

---Converts the RGBA values to a HEX string.
---@param r integer The red value.
---@param g integer The green value.
---@param b integer The blue value.
---@param a number The alpha value in the range 0-1.
---@return string # The hexadecimal value in the format #rrggbb.
function M.color.rgba_to_hex(r, g, b, a)
  r, g, b = limit_rgb(r), limit_rgb(g), limit_rgb(b)
  a = limit_alpha(a)
  return string.format('#%02x%02x%02x', r * a, g * a, b * a)
end

---Converts the HSL values to a HEX string.
---@param h integer The hue value in degrees.
---@param s integer The saturation value in percent.
---@param l integer The lightness value in percent.
---@return string # The hexadecimal value in the format #rrggbb.
function M.color.hsl_to_hex(h, s, l)
  s, l = limit_percent(s), limit_percent(l)
  local r, g, b = hsl_to_rgb(h, s, l)
  return string.format('#%02x%02x%02x', r, g, b)
end

---Converts the HSLA values to a HEX string.
---@param h integer The hue value in degrees.
---@param s integer The saturation value in percent.
---@param l integer The lightness value in percent.
---@param a number The alpha value in the range 0-1.
---@return string # The hexadecimal value in the format #rrggbb.
function M.color.hsla_to_hex(h, s, l, a)
  s, l = limit_percent(s), limit_percent(l)
  a = limit_alpha(a)
  local r, g, b = hsl_to_rgb(h, s, l)
  return string.format('#%02x%02x%02x', r * a, g * a, b * a)
end

---Converts CMYK values to a HEX string.
---@param c integer The cyan value in percent.
---@param m integer The magenta value in percent.
---@param y integer The yellow value in percent.
---@param k integer The black value in percent.
---@return string # The hexadecimal value in the format #rrggbb.
function M.color.cmyk_to_hex(c, m, y, k)
  c, m, y, k = limit_percent(c), limit_percent(m), limit_percent(y), limit_percent(k)
  c, m, y, k = c / 100, m / 100, y / 100, k / 100
  local r = 255 * (1 - c) * (1 - k)
  local g = 255 * (1 - m) * (1 - k)
  local b = 255 * (1 - y) * (1 - k)
  return string.format('#%02x%02x%02x', r, g, b)
end

return M
