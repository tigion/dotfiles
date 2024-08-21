local M = {}

local icons = require('tigion.core.icons')

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

---Returns the LSP servers attached to the current buffer as formatted string.
---@return string
function M.info.lsp_servers()
  local clients = vim.lsp.get_clients({ bufnr = 0 }) -- 0 = current buffer
  local names = {}
  for _, client in pairs(clients) do
    table.insert(names, client.name)
  end
  return table.concat(names, ',')
  -- local lsp_names = ''
  -- if #names > 0 then lsp_names = '' .. table.concat(names, ',') end -- 
  -- return lsp_names
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

---Converts HEX string to RGB values.
---@param hex string The hexadecimal value in the format #rrggbb.
---@return table # The RGB values in the format { r = integer, g = integer, b = integer }.
local function hex_to_rgb(hex)
  return {
    r = tonumber(hex:sub(2, 3), 16),
    g = tonumber(hex:sub(4, 5), 16),
    b = tonumber(hex:sub(6, 7), 16),
  }
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

---Mixes two HEX strings with a certain weighting.
---@param hex1 string The first hexadecimal value in the format #rrggbb.
---@param hex2 string The second hexadecimal value in the format #rrggbb.
---@param weight number The weight of the second color in the range 0-1.
---@return string # The hexadecimal value in the format #rrggbb.
function M.color.mix_hex_colors(hex1, hex2, weight)
  weight = limit_alpha(weight)
  local rgb1 = hex_to_rgb(hex1)
  local rgb2 = hex_to_rgb(hex2)
  local r = math.floor((rgb1.r * (1 - weight) + rgb2.r * weight) + 0.5)
  local g = math.floor((rgb1.g * (1 - weight) + rgb2.g * weight) + 0.5)
  local b = math.floor((rgb1.b * (1 - weight) + rgb2.b * weight) + 0.5)
  return M.color.rgb_to_hex(r, g, b)
end

M.session = {}

---Returns the directory path where session files are stored.
---@return string
local function get_session_directory()
  local dir = vim.fn.stdpath('data') .. '/tigion/sessions'
  return dir
end

---Returns the filename of the session for the current working directory.
---@return string
local function get_session_filename()
  local working_directory = vim.uv.cwd() or 'unknown'
  -- trim leading and trailing slashes (back slashes)
  local filename = working_directory:gsub('^[/\\]+', ''):gsub('[/\\]+$', '')
  -- replace `/:\` (also multiple) with an underscore
  filename = filename:gsub('[:/\\]+', '_')
  return filename .. '.session.vim'
end

function M.session.exists()
  local session_dir = get_session_directory()
  local session_file = get_session_filename()
  local session_filepath = session_dir .. '/' .. session_file
  return vim.fn.filereadable(session_filepath) == 1
end

---Saves the session for the current working directory.
function M.session.save()
  local session_dir = get_session_directory()
  local session_file = get_session_filename()
  local session_filepath = session_dir .. '/' .. session_file
  -- create session directory if it doesn't exist
  if vim.fn.isdirectory(session_dir) == 0 and not vim.fn.mkdir(session_dir, 'p') then
    vim.notify('Failed to create session directory: ' .. session_dir, vim.log.levels.WARN)
    return
  end
  -- ignore nvim-tree and outline windows
  vim.cmd('set sessionoptions-=blank')
  -- save session
  vim.cmd('mksession! ' .. session_filepath)
  vim.notify('Session saved')
end

---Loads the session for the current working directory.
function M.session.load()
  local session_dir = get_session_directory()
  local session_file = get_session_filename()
  local session_filepath = session_dir .. '/' .. session_file
  -- check if session file exists
  if vim.fn.filereadable(session_filepath) ~= 1 then
    -- vim.notify('Session file not found: ' .. session_filepath, vim.log.levels.INFO)
    vim.notify('Session file not found')
    return
  end
  -- load session
  vim.cmd('source ' .. session_filepath)
end

---Shows infos about the session for the current working directory.
function M.session.info()
  local session_dir = get_session_directory()
  local session_file = get_session_filename()
  local session_filepath = session_dir .. '/' .. session_file
  print('Session Info')
  local message = '- Sessions directory'
  if vim.fn.isdirectory(session_dir) ~= 1 then message = message .. ' not' end
  message = message .. ' found: ' .. session_dir
  print(message)
  message = '- Session file'
  if vim.fn.filereadable(session_filepath) ~= 1 then message = message .. ' not' end
  message = message .. ' found: ' .. session_file
  print(message)
end

---Deletes the session for the current working directory.
---@param all? boolean If true, deletes all sessions.
function M.session.delete(all)
  all = all or false
  local session_dir = get_session_directory()
  local session_file = get_session_filename()
  local session_filepath = session_dir .. '/' .. session_file
  if all then
    if vim.fn.delete(session_dir, 'rf') == 0 then
      vim.notify('All sessions deleted')
    else
      vim.notify('No sessions to delete')
    end
  else
    if vim.fn.delete(session_filepath) == 0 then
      vim.notify('Session deleted')
    else
      vim.notify('No session to delete')
    end
  end
end

M.bufferline = {}

---Returns bufferline highlights with own background colors.
---@param bg_default string|nil The default background color for the bufferline.
---@param bg_active string|nil The active background color for the selected buffers.
---@param bg_inactive string|nil The inactive background color for the non-selected buffers.
---@return table
function M.bufferline.background_highlights(bg_default, bg_active, bg_inactive)
  local fill_bg = bg_default
  local tab_bg = bg_inactive
  local tab_selected_bg = bg_active
  local buffer_bg = bg_inactive
  local buffer_visible_bg = bg_active
  local buffer_selected_bg = bg_active

  if bg_default == nil and bg_active == nil and bg_inactive == nil then return {} end

  return {
    -- Base highlights
    fill = { bg = fill_bg }, -- Bufferline background

    -- Tab highlights
    tab = { bg = tab_bg },
    tab_selected = { bg = tab_selected_bg },
    tab_separator = { fg = fill_bg, bg = tab_bg },
    tab_separator_selected = { fg = fill_bg, bg = tab_selected_bg },
    tab_close = { bg = fill_bg },

    -- Buffer highlights
    background = { bg = buffer_bg },

    buffer_visible = { bg = buffer_visible_bg },
    buffer_selected = { bg = buffer_selected_bg },

    close_button = { bg = buffer_bg },
    close_button_visible = { bg = buffer_visible_bg },
    close_button_selected = { bg = buffer_selected_bg },

    indicator_visible = { fg = fill_bg, bg = buffer_visible_bg },
    indicator_selected = { fg = fill_bg, bg = buffer_selected_bg }, -- BUG: Does not work with theme transparency in mode 'thin' for indicator icon!

    separator = { fg = fill_bg, bg = buffer_bg },
    separator_visible = { fg = fill_bg, bg = buffer_visible_bg },
    separator_selected = { fg = fill_bg, bg = buffer_selected_bg },

    modified = { bg = buffer_bg },
    modified_visible = { bg = buffer_visible_bg },
    modified_selected = { bg = buffer_selected_bg },

    duplicate = { bg = buffer_bg },
    duplicate_visible = { bg = buffer_visible_bg },
    duplicate_selected = { bg = buffer_selected_bg },

    diagnostic = { bg = buffer_bg },
    diagnostic_visible = { bg = buffer_visible_bg },
    diagnostic_selected = { bg = buffer_selected_bg },

    error = { bg = buffer_bg },
    error_visible = { bg = buffer_visible_bg },
    error_selected = { bg = buffer_selected_bg },
    warning = { bg = buffer_bg },
    warning_visible = { bg = buffer_visible_bg },
    warning_selected = { bg = buffer_selected_bg },
    info = { bg = buffer_bg },
    info_visible = { bg = buffer_visible_bg },
    info_selected = { bg = buffer_selected_bg },
    hint = { bg = buffer_bg },
    hint_visible = { bg = buffer_visible_bg },
    hint_selected = { bg = buffer_selected_bg },

    error_diagnostic = { bg = buffer_bg },
    error_diagnostic_visible = { bg = buffer_visible_bg },
    error_diagnostic_selected = { bg = buffer_selected_bg },
    warning_diagnostic = { bg = buffer_bg },
    warning_diagnostic_visible = { bg = buffer_visible_bg },
    warning_diagnostic_selected = { bg = buffer_selected_bg },
    info_diagnostic = { bg = buffer_bg },
    info_diagnostic_visible = { bg = buffer_visible_bg },
    info_diagnostic_selected = { bg = buffer_selected_bg },
    hint_diagnostic = { bg = buffer_bg },
    hint_diagnostic_visible = { bg = buffer_visible_bg },
    hint_diagnostic_selected = { bg = buffer_selected_bg },
  }
end

---Returns bufferline highlights with fixed colors
---for theme with activated transparent background.
---@param bg_default string|nil
---@param bg_inactive string|nil
---@return table
function M.bufferline.fixed_highlights(bg_default, bg_inactive)
  return M.bufferline.background_highlights(bg_default, nil, bg_inactive)
end

M.codeium = {}

---Returns Codeium status as formatted string.
---@return string
function M.codeium.status()
  if not pcall(vim.fn['codeium#Enabled']) then return '' end
  if not vim.fn['codeium#Enabled']() then return '' end
  local status = icons.codeium -- '󰘦'
  -- vim.api.nvim_call_function("codeium#GetStatusString", {})
  local str = string.gsub(vim.fn['codeium#GetStatusString'](), '%s+', '')
  if str ~= 'ON' and str ~= '' then status = status .. ' ' .. str end
  return status
end

return M
