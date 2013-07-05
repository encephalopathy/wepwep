require("AIDirector")
require("LevelManager")
require("Player")
-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

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


local function updateBackground()
	background.y = background.y + 1
	if background.y >= 1250 then
		background.y = 720
	end
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	-- create a grey rectangle as the backdrop
	background = display.newImageRect( "sprites/bg_spacesm.png", display.contentWidth, display.contentHeight * 7)
	background:setReferencePoint( display.CenterReferencePoint )
	background.x, background.y = 225, 0
	group:insert( background )
	
	player = Player:new(group, "sprites/player_01.png", display.contentWidth / 2, display.contentHeight / 2, 0, 100, 100)
	
	mainInventory:equip(player, sceneGroup)
	mainInventory:equipSecondaryWeapon(player, sceneGroup)
	
	--powahTimer = timer.performWithDelay(1000, player.regeneratePowah)
	

end



-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	playBGM("/sounds/bgmusic/gameBackMusic.ogg")
	local currentLevel = setLevel(currentLevelNumber)
	print(currentLevel)
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

local function update(event)
--if not pauseGame then

	if not player.alive then
		player.sprite.x = 5000
		player.sprite.y = 5000
	end
	
	AIDirector.update()
	player:cullBulletsOffScreen()
	--updateHaters(step)
	--updateParticleEmitters()
	--mainInventory:checkBullets(haterList)
	--mainInventory:checkBombs(haterList)
	
	
	--[[if step % 20 == 0 and player.isFiring and not cannotFire and (player.powah - player.weapon.energyCost) > 0 then --firing check
		player:fire()
	elseif player.powah < 100 and step % 30 == 0 then --regeneration check
		player.powah = player.powah + 3
	end
	
	displayHealth()
	displayPowah()
   displayAmmoText()
	step = step + 1
	updateBackground()
	
		pauseScreen.x = 40000
		pauseScreen.y = 0
		
		resumeButton.x = 5500
        resumeButton.y = 1000
		
		quitButton.x = 6500
        quitButton.y = 1300
		
		fireSubButton.x = 40
		fireSubButton.y = 590
		
		pauseButton.x = 410
        pauseButton.y = 670
		
		if cannotFire then
			autoFireOffButton.x = 4000
			autoFireOnButton.x = 40
		else
			autoFireOffButton.x = 40
			autoFireOnButton.x = 4000
		end
		
		text1.x = 5500
        text1.y = 1000
		
		dollazText.text = "Dollaz : " .. mainInventory.dollaz
	
end
	if pauseGame then
		pauseScreen.x = 400
		pauseScreen.y = 0
		pauseScreen:setAlpha(0.3)
		
		pauseButton.x = 5500
        pauseButton.y = 1000
		fireSubButton.x = 8000
		
		autoFireOffButton.x = 4000
		autoFireOnButton.x = 4000
		
		resumeButton.x = 410
		resumeButton.y = 670
		quitButton.x = 250
        quitButton.y = 380
		
		text1.x = 200
        text1.y = 150
	end]]--
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