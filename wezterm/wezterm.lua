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

-- config.color_scheme = 'Solarized Dark - Patched'
-- config.color_scheme = 'Catppuccin Mocha'
-- config.color_scheme = 'flexoki-dark'
config.color_scheme = 'Tokyo Night'
-- config.colors = { background = 'black' }
config.window_background_opacity = 0.95
config.window_decorations = 'RESIZE'
config.hide_tab_bar_if_only_one_tab = true
config.native_macos_fullscreen_mode = false
--config.use_fancy_tab_bar = true

config.font = wezterm.font('MesloLGSDZ Nerd Font Mono')
-- config.font = wezterm.font 'Hack Nerd Font Mono'
config.font_size = 17

-- Platform specific settings

-- wezterm.target_triple
-- - x86_64-pc-windows-msvc - Windows
-- - x86_64-apple-darwin - macOS (Intel)
-- - aarch64-apple-darwin - macOS (Apple Silicon)
-- - x86_64-unknown-linux-gnu - Linux
-- wezterm.running_under_wsl
-- - true/false
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  -- Set Pwsh (Powershell on Windows 10) as the default on Windows
  config.default_prog = { 'powershell.exe', '-NoLogo' }
end

-- and finally, return the configuration to wezterm
return config
