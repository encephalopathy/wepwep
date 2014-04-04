-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-- The main menu of SeUPP
-----------------------------------------------------------------------------------------

require "com.Inventory"
require "com.Utility"
require "com.managers.BGM"
require "org.Context"
require "com.mainmenu.views.PlayButton"
require "com.mainmenu.views.EquipButton"
require "com.equipmenu.Shop"
require "com.managers.SFX"
require "com.managers.AIDirector"

local widget = require("widget")

mainInventory = nil
mainInventory = Inventory:new(group)

--global variable for mute
muteOption = true
local muteButtonOff
local muteButtonOn

local storyboard = require("storyboard")
local scene = storyboard.newScene("MainMenu")

-- include Corona's "widget" library
local widget = require "widget"

local context

local mainMenuSFXInfo = {
	enterGame = {path = "com/resources/music/soundfx/enterGame.ogg", channel = 2, setting = 'R'},
	enterEquip = {path = "com/resources/music/soundfx/enterEquip.ogg", channel = 2, setting = 'R'}
}

local function createMainMenuMVC(scene, group)
	context = Context:new(scene)
	context:mapMediator("com.mainmenu.views.PlayButton", "com.mainmenu.mediators.PlayButtonMediator")
    context:mapMediator("com.mainmenu.views.EquipButton", "com.mainmenu.mediators.EquipButtonMediator")
	context:mapMediator("com.mainmenu.views.TestPlayGameButton", "com.mainmenu.mediators.TestGameMediator")
   
    context:preprocess(group)
end

---------------------------------------------

-- forward declarations and other locals
local playButton, weaponShopButton, soundHandler

--Slider listener
local function sliderListener( event )
    local slider = event.target
    local value = event.value
end

-----------------------------------------------------------------------------------------
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
-----------------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	
	-- display a background image
	local background = display.newImageRect( "com/resources/art/background/splash_main_menu.png", display.contentWidth, display.contentHeight )
	
	--background.anchorX = 0
	background.anchorX, background.anchorY = 0, 0
	background.x, background.y = 0, 0
	group:insert( background )
	createMainMenuMVC(scene, group)
	
	soundHandler = SFX:new(group,mainMenuSFXInfo,"mainMenu")
	
	--THESE ARE NOT FINAL! THESE ARE FOR DEBUGGING THE GAME IF YOU DON'T WANT SOUNDS!
	muteButtonOn = widget.newButton
	{
		left = display.contentWidth - display.contentWidth*0.95,
		top = display.contentHeight - display.contentHeight*0.2,
		width = display.contentWidth*0.3,
		height = display.contentHeight*0.2,
		defaultFile = "com/resources/art/sprites/fire_off_unpressed.png",
		overFile = "com/resources/art/sprites/fire_off_pressed.png",
		label = "",
		labelAlign = "center",
		font = "Arial",
		width = width,
		height = height,
		onRelease = function(event)
			muteOption = false
			print("MainMenu_muteOption: ",muteOption)
			playBGM("com/resources/music/bgmusic/menuBackMusic.ogg")
			muteButtonOn.isVisible = false
			muteButtonOff.isVisible = true
		end
	}
	muteButtonOn.baseLabel = ""
	muteButtonOn.isVisible = true
	
	muteButtonOff = widget.newButton
	{
		left = display.contentWidth - display.contentWidth*0.95,
		top = display.contentHeight - display.contentHeight*0.2,
		width = display.contentWidth*0.3,
		height = display.contentHeight*0.2,
		defaultFile = "com/resources/art/sprites/fire_on_unpressed.png",
		overFile = "com/resources/art/sprites/fire_on_pressed.png",
		label = "",
		labelAlign = "center",
		font = "Arial",
		width = width,
		height = height,
		onRelease = function(event)
			muteOption = true
			print("MainMenu_muteOption: ",muteOption)
			stopBGM()
			muteButtonOff.isVisible = false
			muteButtonOn.isVisible = true
		end
	}
	muteButtonOff.baseLabel = ""
	muteButtonOff.isVisible = false
	
	group:insert(muteButtonOn)
	group:insert(muteButtonOff)
	
    --slider = widget.newSlider{top = 750,left = 50,width = 400, listener = sliderListener}

	-- all display objects must be inserted into group.
	-- Adding things to the group works like a stack.  Last thing added appears
	-- on top of everything else.
    --group:insert(slider)

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	
	local group = self.view
	
	if muteOption ~= true then
		playBGM("com/resources/music/bgmusic/menuBackMusic.ogg")
	end
	
	--set up table of soundHandlers
	soundHandler:addListener()
	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	stopBGM()
	
	soundHandler:removeListener()
	
	-- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
	
end


-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	
	-- widgets must be manually removed
	if playButton then
		playButton:removeSelf()
		playButton = nil
	end
	
	if weaponShopButton then
		weaponShopButton:removeSelf()
		weaponShopButton = nil
	end
	
    if slider then
        slider:removeSelf()
        slider = nil
    end    
	
	print("Attempting to free memory")
	if soundHandler then
		soundHandler:disposeSound()
		soundHandler = nil  --make the soundHandler table nil
	end
	print("After disposeSound")
	
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