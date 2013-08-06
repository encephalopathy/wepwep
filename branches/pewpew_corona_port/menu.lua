-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-- The main menu of SeUPP
-----------------------------------------------------------------------------------------

require("Inventory")
require("Utility")
require("BGM")
local M = require("GameConstants")
local widget = require("widget")
require("org.Context")
require "mainmenu.views.PlayButton"
require "mainmenu.views.ShopButton"
require "mainmenu.views.EquipButton"

mainInventory = nil
mainInventory = Inventory:new(group)

local spriteSheet = M.spriteSheet
local sheetInfo   = M.sheetInfo

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "widget" library
local widget = require "widget"

local mainMenuContext

local function createMainMenuMVC()
	mainMenuContext = Context:new()
	mainMenuContext:mapMediator("mainmenu.views.PlayButton", "mainmenu.mediators.PlayButtonMediator", 
   "mainmenu.views.ShopButton", "mainmenu.mediators.ShopButtonMediator", 
   "mainmenu.views.EquipButton", "mainmenu.mediators.EquipButtonMediator")
end

---------------------------------------------

-- forward declarations and other locals
local playButton, weaponShopButton, EquipRideButton

-- 'onRelease' event listener for newGameButton
local function onPlayButtonRelease()
	-- go to level1.lua scene
	storyboard.gotoScene( "level1", "fade", 500 )
	return true	-- indicates successful touch
end

local function onEquipButtonRelease()
	storyboard.gotoScene("MenuEquip", "fade", 500)
	return true
end

local function onWeaponShopButtonRelease()
	storyboard.gotoScene("MenuStore", "fade", 500)
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
	local background = display.newImageRect( "sprites/splash_main_menu.png", display.contentWidth, display.contentHeight )
	background:setReferencePoint( display.TopLeftReferencePoint )
	background.x, background.y = 0, 0
	group:insert( background )
	createMainMenuMVC()
	-- create/position logo/title image on upper-half of the screen
	--local titleLogo = display.newImageRect( "logo.png", 264, 42 )
	--titleLogo:setReferencePoint( display.CenterReferencePoint )
	--titleLogo.x = display.contentWidth * 0.5
	--titleLogo.y = 100
	
	local centerOfScreenX = display.contentWidth*0.5

	local x = centerOfScreenX + 120
	local y = display.contentHeight - 225
	print('Display content x and y: x: ' .. x .. ', ' .. y .. ' )')
	--playButton = createBttn(widget, display, "Play Now", centerOfScreenX + 120, 
	--	display.contentHeight - 225, onPlayButtonRelease)
	local playButton = PlayButton:new(group)
   local shopButton = ShopButton:new(group)
   local equipButton = EquipButton:new(group)

	--weaponShopButton = createBttn(widget, display, "Weapon Shop", display.contentWidth*0.5 - 120,
		--display.contentHeight - 225,onWeaponShopButtonRelease)
		
	--equipRideButton = createBttn(widget, display, "Equip Ride", centerOfScreenX + 120, 
		--display.contentHeight - 75, onEquipButtonRelease)

    slider = widget.newSlider{top = 750,left = 50,width = 400, listener = sliderListener}
	
	-- all display objects must be inserted into group.
	-- Adding things to the group works like a stack.  Last thing added appears
	-- on top of everything else.
	--group:insert( titleLogo )
	
	--group:insert( weaponShopButton )
	--group:insert( equipRideButton )
	--group:insert( playButton )
    group:insert(slider)		

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	playBGM("/sounds/bgmusic/menuBackMusic.ogg")
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