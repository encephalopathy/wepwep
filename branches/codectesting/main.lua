--[[
codec.lua (main.lua)

A separate module for all of the codec's operations
]]--


-- memory checking function
local function checkMemory()
   collectgarbage( "collect" )
   local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
   print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end
--timer.performWithDelay( 1000, checkMemory, 0 )


-- import all the codec information
local c = require("codec")


-- fire off the codec!
--Runtime:dispatchEvent(c.codecStartEvent)

print("I am at the end of main.")