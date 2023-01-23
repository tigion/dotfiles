local status, alpha = pcall(require, 'alpha')
if not status then return end

local dashboard = require 'alpha.themes.dashboard'

-- Banner
local banner = {
  '                                                    ',
  ' ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
  ' ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
  ' ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
  ' ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
  ' ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
  ' ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
  '                                                    ',
}
banner = {
  ' Neovim ',
}
dashboard.section.header.val = banner

-- Menu
dashboard.section.buttons.val = {
  dashboard.button('e', '󰈔  New file', ':ene <BAR> startinsert<CR>'),
  dashboard.button('r', '󱔗  Recent files', ':Telescope oldfiles <CR>'),
  dashboard.button('f', '󰱼  Find file', ':Telescope find_files<CR>'),
  dashboard.button('g', '󰺮  Find text', ':Telescope live_grep <CR>'),
  dashboard.button('h', '󱤇  Find help tag', ':Telescope help_tags <CR>'),
  dashboard.button('s', '  Settings', ':cd ~/.config/nvim/<CR> :e .<CR>'),
  dashboard.button('u', '  Update plugins', ':PackerSync<CR>'),
  dashboard.button('c', '  Check health', ':checkhealth<CR>'),
  dashboard.button('q', '  Quit', ':qa<CR>'),
}

-- Footer
local function footer()
  local version = vim.version()
  local print_version = 'v' .. version.major .. '.' .. version.minor .. '.' .. version.patch
  local datetime = os.date '%d.%m.%Y %H:%M'

  --return print_version .. ' - ' .. datetime
  return print_version
end

dashboard.section.footer.val = footer()

-- Colors
for _, button in ipairs(dashboard.section.buttons.val) do
  --button.opts.width = 40
  button.opts.hl = "AlphaButtons"
  button.opts.hl_shortcut = "AlphaShortcut"
end
dashboard.section.header.opts.hl = 'AlphaHeader'
dashboard.section.buttons.opts.hl = 'AlphaButtons'
dashboard.section.footer.opts.hl = 'AlphaFooter'
dashboard.opts.layout[1].val = 6

alpha.setup(dashboard.config)
