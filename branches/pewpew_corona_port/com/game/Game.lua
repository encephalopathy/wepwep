require "org.Context"
require "com.managers.LevelManager"
require "com.managers.AIDirector"
require "com.managers.BulletManager"
require "com.managers.CollectibleHeap"
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
local debugFlag = true
-- local variables
local player = nil
local playerStartLocation = { x = display.contentWidth / 2, y =  display.contentHeight / 2 }
local background = nil
local backgroundBuffer = nil
local currentLevelNumber = 1
step = 0

--[[  DEBUG ]]--
local healthRectBG, powahRectBG, powahRect, healthRect

local gameContext


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



--[[local function createGameUIMVC(group)
	gameContext = Context:new()
	gameContext:mapMediator("com.mainmenu.views.SecondaryFireButton", "com.mainmenu.mediators.SecondaryFireButtonMediator")
    gameContext:mapMediator("com.mainmenu.views.SecondaryFireButton", "com.mainmenu.mediators.SecondaryFireButtonMediator")
    gameContext:mapMediator("com.mainmenu.views.SecondaryFireButton", "com.mainmenu.mediators.SecondaryFireButtonMediator")
   
    gameContext:preprocess(group)
end]]--

local function debugUpdate()
	if not debugFlag then
		healthRect.width = (display.contentWidth/2.05)*(player.health/player.maxhealth)
		powahRect.height = (display.contentHeight/2.05)*(player.powah/PLAYER_MAXPOWAH)
	end
end

local function debugAdd(group)
	if not debugFlag then
		healthRectBG = display.newRect(display.contentWidth/20, display.contentHeight/50, display.contentWidth/2, display.contentHeight/23)
		healthRectBG:setFillColor(150, 150, 150, 120)

		powahRectBG = display.newRect(display.contentWidth/20, display.contentHeight/12, display.contentWidth/17, display.contentHeight/2)
		powahRectBG:setFillColor(150, 150, 150, 120)

		powahRect = display.newRect(display.contentWidth/18 , display.contentHeight/11, display.contentWidth/20, display.contentHeight/2.05)
		powahRect:setFillColor(50, 80, 200, 140)

		healthRect = display.newRect(display.contentWidth/18, display.contentHeight/40 , display.contentWidth/2.05, display.contentHeight/30)
		healthRect:setFillColor(50, 220, 80, 140)
		
		group:insert(healthRectBG)
		group:insert(powahRectBG)
		group:insert(powahRect)
		group:insert(healthRect)
	end
end

local function debugRemove(group)
	if not debugFlag then
		group:remove(healthRectBG)
		group:remove(powahRectBG)
		group:remove(powahRect)
		group:remove(healthRect)
	end
end

local function update(event)
	
	updateParticleEmitters()
--if not pauseGame then
   -- print("I am updating")
	if not player.alive and not deflagFlag then
		audio.stop()
		storyboard.gotoScene("com.mainmenu.MainMenu", "fade", 500)
		player.sprite.x = 4000
		player.sprite.y = 4000
	end
	
	collectibles:update()
	AIDirector.update()
	if(player.isFiring) then 
		player:fire()
	else
		player:regeneratePowah()
	end
	
	player:updatePassives()
	player:cullBulletsOffScreen()
	
	debugUpdate()
	
	step = step + 1
end

-- scrolls background of gamestate
local function updateBackground()
	background.y = background.y + 10
	backgroundBuffer.y = backgroundBuffer.y + 10
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
	
	
	AIDirector.create(group)
	collectibles = CollectibleHeap:new(group, {'HealthPickUp'})
	bulletManager = BulletManager:new(group)
	group:insert( myButton )
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
	
	--TODO: when weapons are done testing, swap the order of creation of haters with the player initialization calls.
	
	debugFlag = event.params.debug
	local currentLevel = setLevel('test') --set to be the default level
	AIDirector.initialize(player, currentLevel)
	
	player.sprite.x, player.sprite.y = playerStartLocation.x, playerStartLocation.y
	
	--This line below will eventually be moved to debug add when Inventory and shop menu work.
	player:equipDebug(group)
	
	player.weapon.targets = AIDirector.haterList
	
	step = 0
	
	collectibles:start()
	bulletManager:start()
	Runtime:addEventListener("enterFrame", update )
	Runtime:addEventListener("enterFrame", updateBackground )
	
	debugAdd(group)
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	print('Exiting scene')
	local group = self.view
	
	stopBGM()
	
	AIDirector.uninitialize(group)
	collectibles:stop(group)
	bulletManager:stop(group)
	destroyParticleManager()
	Runtime:removeEventListener("enterFrame", update )
	Runtime:removeEventListener("enterFrame", updateBackground )
	step = 0
	
	if not debugFlag then
		shopInventory:setDefaultAmmoAmount()
	end
	debugRemove(group)
	
	physics.pause()
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	print('destroying scene')
	local group = self.view
	
	group:remove(AIDirector.haterGroup)
	AIDirector.haterGroup = nil
	group:remove(bulletManager.bulletGroupInView)
	bulletManager.bulletGroupInView = nil
	collectibles:destroy()
	
	
	package.loaded[physics] = nil
	physics = nil
	if myButton then
		myButton:removeSelf()	-- widgets must be manually removed
		myButton = nil
	end
end

--[[function particleCoroutine ()
    return coroutine.ParticleCoroutine(function ()
    updateParticleEmitters()
    end)
end]]--

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