--print("Hello from lua/tigion/core/init.lua")

-- core
require('tigion.core.options')
require('tigion.core.keymaps')
require('tigion.core.autocmds')

-- Version specific
if vim.fn.has('nvim-0.12') == 1 then require('tigion.core.nvim_0_12') end
