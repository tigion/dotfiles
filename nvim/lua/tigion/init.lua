--print("Hello from lua/tigion/init.lua")

require 'tigion.base'
require 'tigion.highlights'
require 'tigion.keymaps'
require 'tigion.plugins'

local has = vim.fn.has
local isMac = has 'macunix'
local isWin = has 'win32'

if isMac then
  require 'tigion.macos'
elseif isWin then
  require 'tigion.windows'
end
