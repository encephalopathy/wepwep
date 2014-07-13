-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
--require("LevelManager")
require 'org.DynamicQueue'

system.activate("multitouch")

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "storyboard" module
local storyboard = require "storyboard"

-- load menu screen
storyboard.gotoScene( "com.mainmenu.MainMenu" )

-- memory management function
-- use the Corona Debugger to find memory usage
local monitorMem = function()

    collectgarbage()
    local sysMem = collectgarbage("count")
    --print( "MemUsage: " .. sysMem )

    local textMem = system.getInfo( "textureMemoryUsed" ) / 1000000
    --print( "TexMem:   " .. textMem )
end

Runtime:addEventListener( "enterFrame", monitorMem )