-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-- The first level of the game. Currently, the level that is played as soon as the player
-- presses the "Play Now" button in the main menu
-----------------------------------------------------------------------------------------

require("AIDirector")
require("LevelManager")
require("Player")
local M = require("GameConstants")

local spriteSheet = M.spriteSheet
local sheetInfo   = M.sheetInfo

-- scene managment api, dictates game scene transition
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "widget" library
local widget = require "widget"

-- local variables
local player, background, backgroundBuffer = nil
local currentLevelNumber = 0
step = 0

-- include Corona's "physics" library
local physics = require "physics"
physics.start(); physics.pause()
physics.setGravity(0, 0)
physics.setVelocityIterations(1)
physics.setPositionIterations(1)

--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5

-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-- 
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------

local newCoroutine = coroutine.create(function()
	while true do
	--	print("foo", 1)
		updateParticleEmitters()
    	coroutine.yield()
    	--print("foo", 2)
    end
end
)

-- scrolls background of gamestate
local function updateBackground()
	background.y = background.y + 10
	backgroundBuffer.y = backgroundBuffer.y + 10
	if background.y >= 3600 then
		background.y = 0
		backgroundBuffer.y = -3600
	end
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	-- the scrolling background that appears during play
	background = display.newImageRect(spriteSheet, sheetInfo.frameIndex["bg_spacesm"],
	                                   display.contentWidth, display.contentHeight * 7)
	background:setReferencePoint( display.CenterReferencePoint )
	background.x, background.y = 225, 0
	group:insert(background)
	
	-- the second part of the background that allows for seamless scrolling
	backgroundBuffer = display.newImageRect(spriteSheet, sheetInfo.frameIndex["bg_spacesm"],
	                                        display.contentWidth, display.contentHeight * 7)
	backgroundBuffer:setReferencePoint( display.CenterReferencePoint )
	backgroundBuffer.x, backgroundBuffer.y = 225, -3600
	group:insert(backgroundBuffer)
	
	player = Player:new(group, "sprites/player_01mosaicfilter.png", display.contentWidth / 2, display.contentHeight / 2, 0, 100, 100)
	
    local myButton = widget.newButton
    {
        left = screenW - screenW*0.3,
        top = screenH - screenH*0.15,
        width = screenW*0.3,
        height = screenH*0.2,
        defaultFile = "sprites/backtomenu_unpressed.png",
        overFile = "sprites/backtomenu_pressed.png",
        label = "",
        labelAlign = "center",
        font = "Arial",
        fontSize = 18,
        labelColor = { default = {0,0,0}, over = {255,255,255} },
        onRelease = back
    }
    myButton.baseLabel = ""

    group:insert( myButton )
	
	mainInventory:equipRig(player, sceneGroup)
	
	--powahTimer = timer.performWithDelay(1000, player.regeneratePowah)
end


-- TODO: This function should be above the scene:createScene function, but when it's
-- moved there, everything blows up
local function back()
    audio.stop()
	storyboard.gotoScene("menu", "fade", 500)
	return true
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	playBGM("/sounds/bgmusic/gameBackMusic.ogg")
	local currentLevel = setLevel(currentLevelNumber)
	AIDirector.initialize(player, currentLevel)
	physics.start()
	step = 0
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	mainInventory.equippedGameWeapon:unload()
    mainInventory.equippedSecondaryGameWeapon:unload()
	physics.stop()
	step = 0
end


-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	
	package.loaded[physics] = nil
	physics = nil
	if myButton then
		myButton:removeSelf()	-- widgets must be manually removed
		myButton = nil
	end
end


function particleCoroutine (a)
    return coroutine.ParticleCoroutine(function ()
    updateParticleEmitters()
    end)
end


local function update(event)
	
	coroutine.resume(newCoroutine)
	if not player.alive then
		player.sprite.x = 4000
		player.sprite.y = 4000
	end
	
	AIDirector.update()
	player:cullBulletsOffScreen()
--	updateParticleEmitters()
	step = step + 1
end


-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

Runtime:addEventListener("enterFrame", update )

Runtime:addEventListener("enterFrame", updateBackground )

-----------------------------------------------------------------------------------------

return scene