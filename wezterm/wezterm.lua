-- Pull in the wezterm API
local wezterm = require('wezterm')

-- This will hold the configuration.
-- local config = {}
-- if wezterm.config_builder then
--   config = wezterm.config_builder()
-- end
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Settings

--config.color_scheme = 'Solarized Dark - Patched'
--config.color_scheme = 'Catppuccin Mocha'
--config.color_scheme = 'flexoki-dark'
config.colors = { background = 'black' }
config.window_background_opacity = 0.95
config.font_size = 11
--config.use_fancy_tab_bar = true

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  -- Set Pwsh (Powershell on Windows 10) as the default on Windows
  config.default_prog = { 'powershell.exe', '-NoLogo' }
end

-- and finally, return the configuration to wezterm
return config
