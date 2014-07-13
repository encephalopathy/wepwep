-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

require 'luaunit_v13.luaunit'

local storyboard = require "storyboard"

storyboard.gotoScene( "com.mainmenu.MainMenu" )

local options = { effect = "fade", time = 500, params = { debug = false } }

storyboard.gotoScene( "com.equipmenu.MenuEquip")










