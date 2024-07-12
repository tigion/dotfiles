return {
  'goolord/alpha-nvim',
  config = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')

    local nvim_version = require('tigion.core.util').info.nvim_version
    local plugin_count = require('tigion.core.util').info.plugin_count

    -- local variables
    local win_height = vim.fn.winheight(0)
    local button_width = 40

    -- Sets the header with a banner ascii art or text.
    -- local banner = {
    --   '  _  _             _        ',
    --   ' | \\| |___ _____ _(_)_ __   ',
    --   " | .` / -_) _ \\ V / | '  \\  ",
    --   ' |_|\\_\\___\\___/\\_/|_|_|_|_| ',
    -- }
    local banner = {
      [[  _  _             _        ]],
      [[ | \| |___ _____ _(_)_ __   ]],
      [[ | .` / -_) _ \ V / | '  \  ]],
      [[ |_|\_\___\___/\_/|_|_|_|_| ]],
    }
    -- local banner = {
    --   ' Neovim ',
    -- }
    dashboard.section.header.val = banner

    -- Sets the buttons with icons and text in the Menu.
    dashboard.section.buttons.val = {
      dashboard.button('e', '󰈔 New file', ':ene <BAR> startinsert<CR>'),
      dashboard.button('r', '󱔗 Recent files', ':Telescope oldfiles <CR>'),
      dashboard.button('f', '󰱼 Find file', ':Telescope find_files<CR>'),
      dashboard.button('g', '󰺮 Find text', ':Telescope live_grep <CR>'),
      dashboard.button('h', '󱤇 Find help tag', ':Telescope help_tags <CR>'),
      -- dashboard.button('s', ' Settings', ':cd ' .. vim.fn.stdpath('config') .. '<CR> :e .<CR>'),
      dashboard.button('s', ' Settings', ':cd ' .. vim.fn.stdpath('config') .. '<CR>:NvimTreeOpen<CR>'),
      dashboard.button('p', ' Check plugins', ':Lazy check<CR>'),
      dashboard.button('c', ' Check health', ':checkhealth<CR>'),
      dashboard.button('q', ' Quit', ':qa<CR>'),
    }

    -- Sets the footer text.
    local version, count, date = nvim_version(), plugin_count(), os.date('%d.%m.%Y')
    dashboard.section.footer.val = ' ' .. version .. '   ' .. count .. '   ' .. date

    -- Sets the color highlight groups of the color scheme.
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.width = button_width
      button.opts.hl = 'AlphaButtons'
      button.opts.hl_shortcut = 'AlphaShortcut'
    end
    dashboard.section.header.opts.hl = 'AlphaHeader'
    dashboard.section.buttons.opts.hl = 'AlphaButtons'
    dashboard.section.footer.opts.hl = 'AlphaFooter'

    -- Returns the height of the dashboard content.
    ---@return integer
    local function get_dashboard_height()
      local banner_height = 0
      for _ in pairs(dashboard.section.header.val) do
        banner_height = banner_height + 1
      end
      local button_count = 0
      for _ in pairs(dashboard.section.buttons.val) do
        button_count = button_count + 1
      end
      local buttons_height = 2 * button_count
      local footer_height = 1
      local dashboard_height = banner_height + dashboard.opts.layout[3].val + buttons_height + footer_height
      return dashboard_height
    end

    -- Reduce dashboard size for small window heights
    if win_height < get_dashboard_height() + 3 then
      dashboard.section.header.val = { 'Neovim' }
      table.remove(dashboard.section.buttons.val, 5)
      table.remove(dashboard.section.buttons.val, 5)
      table.remove(dashboard.section.buttons.val, 5)
      table.remove(dashboard.section.buttons.val, 5)
    end

    -- Align dashboard vertically
    local topSpace = vim.fn.max({ 0, vim.fn.floor((vim.fn.winheight(0) - get_dashboard_height()) / 2) })
    dashboard.opts.layout[1].val = topSpace

    -- Setup
    alpha.setup(dashboard.config)
  end,
}
