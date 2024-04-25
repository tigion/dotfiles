return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  keys = function()
    local keys = {
      {
        '<leader>H',
        function() require('harpoon'):list():add() end,
        desc = 'Harpoon File (add)',
      },
      {
        '<leader>h',
        function()
          local harpoon = require('harpoon')
          local toggle_opts = { -- HarpoonToggleOptions (ui.lua)
            border = 'rounded',
            title_pos = 'center',
          }
          harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts)
        end,
        desc = 'Harpoon Quick Menu',
      },
    }

    for i = 1, 5 do
      table.insert(keys, {
        '<leader>' .. i,
        function() require('harpoon'):list():select(i) end,
        desc = 'Harpoon to File ' .. i,
      })
    end
    return keys
  end,
  opts = {
    settings = {
      save_on_toggle = true,
    },
  },
}
