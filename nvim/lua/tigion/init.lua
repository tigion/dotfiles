--print("Hello from lua/tigion/init.lua")

-- core
require('tigion.core')

-- plugins
IS_ALLOWED_PLUGIN = require('tigion.core.util').is_allowed_on_host()
require('tigion.lazy')
