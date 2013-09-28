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
require "com.managers.LevelManager"
require "com.mainmenu.views.PlayButton"
require "com.mainmenu.views.ShopButton"
require "com.mainmenu.views.EquipButton"

local widget = require("widget")

mainInventory = nil
mainInventory = Inventory:new(group)


local storyboard = require("storyboard")
local scene = storyboard.newScene("MainMenu")

-- include Corona's "widget" library
local widget = require "widget"

local mainMenuContext

local function createMainMenuMVC(group)
	mainMenuContext = Context:new()
	mainMenuContext:mapMediator("com.mainmenu.views.PlayButton", "com.mainmenu.mediators.PlayButtonMediator")
    mainMenuContext:mapMediator("com.mainmenu.views.ShopButton", "com.mainmenu.mediators.ShopButtonMediator")
    mainMenuContext:mapMediator("com.mainmenu.views.EquipButton", "com.mainmenu.mediators.EquipButtonMediator")
   
    mainMenuContext:preprocess(group)
end

---------------------------------------------

-- forward declarations and other locals
local playButton, weaponShopButton, EquipRideButton

-- 'onRelease' event listener for newGameButton
local function onPlayButtonRelease()
	-- go to level1.lua scene
	storyboard.gotoScene( "com.game.Game", "fade", 500 )
	return true	-- indicates successful touch
end

local function onEquipButtonRelease()
	storyboard.gotoScene("com.equipmenu.MenuEquip", "fade", 500)
	return true
end

local function onWeaponShopButtonRelease()
	storyboard.gotoScene("com.shopmenu.MenuStore", "fade", 500)
	return true
end

local function onDefaultRelease()
	-- print('hello this button does not do anything')
	return true
end


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
	
	background:setReferencePoint( display.TopLeftReferencePoint )
	background.x, background.y = 0, 0
	group:insert( background )
	createMainMenuMVC(group)

    slider = widget.newSlider{top = 750,left = 50,width = 400, listener = sliderListener}
	
	-- all display objects must be inserted into group.
	-- Adding things to the group works like a stack.  Last thing added appears
	-- on top of everything else.
    group:insert(slider)

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	playBGM("com/resources/music/bgmusic/menuBackMusic.ogg")
	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	stopBGM()
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