--print("Hello from lua/tigion/core/init.lua")

-- core
require('tigion.core.base')
require('tigion.core.highlights')
require('tigion.core.keymaps')

-- os specific
local has = vim.fn.has
local isMac = has('macunix')
local isWin = has('win32')

if isMac then
  require('tigion.core.macos')
elseif isWin then
  require('tigion.core.windows')
end

