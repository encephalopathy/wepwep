-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

require 'Test.More'
require 'managers.levelmanager_test'

local storyboard = require "storyboard"

storyboard.gotoScene( "com.mainmenu.MainMenu" )

local options = { effect = "fade", time = 500, params = { debug = false } }
storyboard.gotoScene( "com.game.Game", options )

runLevelManagerParseTest()







