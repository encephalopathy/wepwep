require("AIDirector")
require("LevelManager")
require("Player")
-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

-- scene managment api, dictates game scene transition
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- local variables
local player = nil
local background = nil
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

newCoroutine = coroutine.create(function()
	
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
	background.y = background.y + 20
	if background.y >= 1250 then
		background.y = 720
	end
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	-- creates backdrop of current game
	background = display.newImageRect( "sprites/bg_spacesm.png", display.contentWidth, display.contentHeight * 7)
	background:setReferencePoint( display.CenterReferencePoint )
	background.x, background.y = 225, 0
	group:insert( background )
	
	player = Player:new(group, "sprites/player_01mosaicfilter.png", display.contentWidth / 2, display.contentHeight / 2, 0, 100, 100)
	
	mainInventory:equip(player, sceneGroup)
	mainInventory:equipSecondaryWeapon(player, sceneGroup)	
end



-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	playBGM("/sounds/bgmusic/gameBackMusic.ogg")
	local currentLevel = setLevel(currentLevelNumber)
	AIDirector.initialize(player, currentLevel)
	physics.start()

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
end

function particleCoroutine (a)
    return coroutine.ParticleCoroutine(function ()
    updateParticleEmitters()
    end)
end

local function update(event)
	
	coroutine.resume(newCoroutine)
--if not pauseGame then
   -- print("I am updating")
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