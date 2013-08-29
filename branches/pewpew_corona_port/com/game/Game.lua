require "com.managers.AIDirector"
require "com.managers.LevelManager"
require "com.managers.BulletManager"
require "com.game.Player"
-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

-- scene managment api, dictates game scene transition
local storyboard = require( "storyboard" )
local scene = storyboard.newScene("game")

-- include Corona's "widget" library
local widget = require "widget"

-- local variables
local player = nil
local playerStartLocation = { x = display.contentWidth / 2, y =  display.contentHeight / 2 }
local background = nil
local backgroundBuffer = nil
local currentLevelNumber = 1
step = 0

-- include Corona's "physics" library
local physics = require "physics"
physics.start(); physics.pause()
physics.setGravity(0, 0)
physics.setVelocityIterations(1)
physics.setPositionIterations(1)

usingBulletManagerBullets = true

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
		updateParticleEmitters()
    	coroutine.yield()
    end
end
)

local function update(event)
	
	coroutine.resume(newCoroutine)
--if not pauseGame then
   -- print("I am updating")
	if not player.alive then
		player.sprite.x = 4000
		player.sprite.y = 4000
	end
	if(player.isFiring) then 
		player:fire()
	else
		player:regeneratePowah()
	end
	player:cullBulletsOffScreen()
--	updateParticleEmitters()
	step = step + 1
end

-- scrolls background of gamestate
local function updateBackground()
	background.y = background.y + 10
	backgroundBuffer.y = backgroundBuffer.y + 10
	--background.x = 10
	--backgroundBuffer.x = 70
	if background.y >= 3600 then
		background.y = 0
		backgroundBuffer.y = -3600
	end
end

-- creates the scrolling background for the current game
local function createScrollingBackground(scene)
	-- creates the maindropBuffer of the game
	background = display.newImageRect( "com/resources/art/background/bg_spacesm.png", display.contentWidth, display.contentHeight * 7)
	background:setReferencePoint( display.CenterReferencePoint )
	background.x, background.y = 225, 0
	scene:insert( background )
	
	-- creates backdropBuffer of current game
	backgroundBuffer = display.newImageRect( "com/resources/art/background/bg_spacesm.png", display.contentWidth, display.contentHeight * 7)
	backgroundBuffer:setReferencePoint( display.CenterReferencePoint )
	backgroundBuffer.x, backgroundBuffer.y = 225, -3600
	scene:insert(  backgroundBuffer )
end

local function back()
    audio.stop()
	storyboard.gotoScene("com.mainmenu.MainMenu", "fade", 500)
	return true
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	print('Create Scene')
	local group = self.view

	-- creates the scrolling background for the current game
	createScrollingBackground(group)
	
	player = Player:new(group, "com/resources/art/sprites/player_01mosaicfilter.png", display.contentWidth / 2, display.contentHeight / 2, 0, 100, 100)
	bulletManager = BulletManager:new(group)
	
	
	local myButton = widget.newButton
	{
		left = screenW - screenW*0.3,
		top = screenH - screenH*0.15,
		width = screenW*0.3,
		height = screenH*0.2,
		defaultFile = "com/resources/art/sprites/backtomenu_unpressed.png",
		overFile = "com/resources/art/sprites/backtomenu_pressed.png",
		label = "",
		labelAlign = "center",
		font = "Arial",
		width = width,
		height = height,
		onRelease = function(event)
			audio.stop()
			storyboard.gotoScene("com.mainmenu.MainMenu", "fade", 500)
		end
	}
	myButton.baseLabel = ""

	group:insert( myButton )
	
	print('level1 scenegroup')
	print(group)
	--mainInventory:equipRig(player, sceneGroup)
	
	--powahTimer = timer.performWithDelay(1000, player.regeneratePowah)
	

end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	print('Enter Scene')
	local group = self.view
	playBGM("com/resources/music/bgmusic/gameBackMusic.ogg")
	physics.start()
	physics.setGravity(0, 0)
	physics.setVelocityIterations(1)
	physics.setPositionIterations(1)
	
	local currentLevel = setLevel('ap')
	AIDirector.initialize(group, player, currentLevel)
	bulletManager:start()
	
	player.sprite.x, player.sprite.y = playerStartLocation.x, playerStartLocation.y
	player:weaponEquipDebug(group)
	player.weapon.targets = AIDirector.haterList
	step = 0
	Runtime:addEventListener("enterFrame", update )
	Runtime:addEventListener("enterFrame", updateBackground )
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	print('Exiting scene')
	local group = self.view
	--stopBGM()
	AIDirector.uninitialize(group)
	destroyParticleManager()
	bulletManager:stop()
	

	Runtime:removeEventListener("enterFrame", update )
	Runtime:removeEventListener("enterFrame", updateBackground )
	step = 0
	physics.pause()
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	print('destroying scene')
	local group = self.view
	
	package.loaded[physics] = nil
	physics = nil
	if myButton then
		myButton:removeSelf()	-- widgets must be manually removed
		myButton = nil
	end
end

function particleCoroutine ()
    return coroutine.ParticleCoroutine(function ()
    updateParticleEmitters()
    end)
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



-----------------------------------------------------------------------------------------

return scene