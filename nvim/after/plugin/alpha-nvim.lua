local status, alpha = pcall(require, 'alpha')
if not status then return end

local dashboard = require 'alpha.themes.dashboard'

-- local variables
local winHeight = vim.fn.winheight(0)
local buttonWidth = 40

-- Banner
-- local banner = {
--   '                                                    ',
--   ' ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
--   ' ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
--   ' ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
--   ' ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
--   ' ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
--   ' ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
--   '                                                    ',
-- }
-- local banner = {
--   '                        _            ',
--   '                       (_)           ',
--   '  _ __   ___  _____   ___ _ __ ___   ',
--   ' | \'_ \\ / _ \\/ _ \\ \\ / / | \'_ ` _ \\  ',
--   ' | | | |  __/ (_) \\ V /| | | | | | | ',
--   ' |_| |_|\\___|\\___/ \\_/ |_|_| |_| |_| ',
--   '                                     ',
-- }
-- local banner = {
--   '  _  _  ____  _____  _  _  ____  __  __  ',
--   ' ( \\( )( ___)(  _  )( \\/ )(_  _)(  \\/  ) ',
--   '  )  (  )__)  )(_)(  \\  /  _)(_  )    (  ',
--   ' (_)\\_)(____)(_____)  \\/  (____)(_/\\/\\_) ',
-- }
-- local banner = {
--   '  _______                     __            ',
--   ' |    |  |.-----.-----.--.--.|__|.--------. ',
--   ' |       ||  -__|  _  |  |  ||  ||        | ',
--   ' |__|____||_____|_____|\\___/ |__||__|__|__| ',
-- }
-- local banner = {
--   '  _____             _        ',
--   ' |   | |___ ___ _ _|_|_____  ',
--   ' | | | | -_| . | | | |     | ',
--   ' |_|___|___|___|\\_/|_|_|_|_| ',
-- }
local banner = {
  '  _  _             _        ',
  ' | \\| |___ _____ _(_)_ __   ',
  ' | .` / -_) _ \\ V / | \'  \\  ',
  ' |_|\\_\\___\\___/\\_/|_|_|_|_| ',
}
-- local banner = {
--   ' Neovim ',
-- }
dashboard.section.header.val = banner

-- Menu
dashboard.section.buttons.val = {
  dashboard.button('e', '󰈔  New file', ':ene <BAR> startinsert<CR>'),
  dashboard.button('r', '󱔗  Recent files', ':Telescope oldfiles <CR>'),
  dashboard.button('f', '󰱼  Find file', ':Telescope find_files<CR>'),
  dashboard.button('g', '󰺮  Find text', ':Telescope live_grep <CR>'),
  dashboard.button('h', '󱤇  Find help tag', ':Telescope help_tags <CR>'),
  dashboard.button('s', '  Settings', ':cd ~/.config/nvim/<CR> :e .<CR>'),
  dashboard.button('u', '  Update plugins', ':PackerSync<CR>'),
  dashboard.button('c', '  Check health', ':checkhealth<CR>'),
  dashboard.button('q', '  Quit', ':qa<CR>'),
}

-- Footer
local function footer()
  local version = vim.version()
  local print_version = 'v' .. version.major .. '.' .. version.minor .. '.' .. version.patch
  --local datetime = os.date '%d.%m.%Y %H:%M'
  --return print_version .. ' - ' .. datetime
  return print_version
end

dashboard.section.footer.val = footer()

-- Colors
-- defined in color theme (after/plugin/neosolarized.rc.lua)
for _, button in ipairs(dashboard.section.buttons.val) do
  button.opts.width = buttonWidth
  button.opts.hl = "AlphaButtons"
  button.opts.hl_shortcut = "AlphaShortcut"
end
dashboard.section.header.opts.hl = 'AlphaHeader'
dashboard.section.buttons.opts.hl = 'AlphaButtons'
dashboard.section.footer.opts.hl = 'AlphaFooter'

-- Align dashboard vertically
local function getDashboardHeight()
  local bannerHeight = 0
  for _ in pairs(dashboard.section.header.val) do bannerHeight = bannerHeight + 1 end
  local buttonCount = 0
  for _ in pairs(dashboard.section.buttons.val) do buttonCount = buttonCount + 1 end
  local buttonsHeight = 2 * buttonCount
  local footerHeight = 1
  local dashboardHeight = bannerHeight + dashboard.opts.layout[3].val + buttonsHeight + footerHeight
  return dashboardHeight
end

if winHeight < getDashboardHeight() + 3 then
  -- Reduce dashboard size for small window heights
  dashboard.section.header.val = { 'Neovim' }
  table.remove(dashboard.section.buttons.val, 5)
  table.remove(dashboard.section.buttons.val, 5)
  table.remove(dashboard.section.buttons.val, 5)
  table.remove(dashboard.section.buttons.val, 5)
end
local topSpace = vim.fn.max({ 0, vim.fn.floor((vim.fn.winheight(0) - getDashboardHeight()) / 2) })
dashboard.opts.layout[1].val = topSpace

-- Setup
alpha.setup(dashboard.config)
