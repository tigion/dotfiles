--print("Hello from lua/tigion/init.lua")

-- core
require('tigion.core')

-- plugins
IS_ALLOWED_PLUGIN = require('tigion.core.util').check.is_allowed_host()
require('tigion.lazy')
