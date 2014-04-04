-----------------------------------------------------------------------------------------
--
-- EquipMenu.lua
--
-----------------------------------------------------------------------------------------
require "com.Utility"
require "com.Inventory"
require "org.Object"
require "org.Queue"
require "com.equipmenu.Carousel"

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
-- include Corona's "widget" library
local widget = require "widget_corona.widgetLibrary.widget"

local dollaztext
local weighttext

local context
--------------------------------------------

-- forward declarations and other locals

local function createEquipMenuMVC(scene, group)
	context = Context:new(scene)
	context:mapMediator("com.equipmenu.views.CarouselView", "com.equipmenu.mediators.ShopMediator")
	context:mapMediator("com.equipmenu.views.ToolTipView", "com.equipmenu.mediators.ShopMediator")
	context:mapMediator("com.equipmenu.views.InventoryView", "com.equipmenu.mediators.ShopMediator")
   
    context:preprocess(group)
end
-- 'onRelease' event listener for newGameButton
local function back()	
	-- go to menu
	storyboard.gotoScene( "com.mainmenu.MainMenu", "fade", 500 )
	return true	-- indicates successful touch
end

	"com/resources/art/sprites/missile.png", 'com/resources/art/sprites/shop_splash_images/NRGRegen.jpg', 'com/resources/art/sprites/shop_splash_images/HealthPickUp.png', 'com/resources/art/sprites/shop_splash_images/ActivatableShield.png', 'com/resources/art/sprites/shop_splash_images/PassiveShield.png'}


-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-- 
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	
	print('Shop group' .. tostring(group))
	shop = Shop:new(group)
	-- display a background image
	local background = display.newImageRect("com/resources/art/background/sheet_metal.png",
	                                        display.contentWidth, display.contentHeight )

	background.anchorX, background.anchorY = 0, 0
	background.x, background.y = 0, 0
	
	local bgRect = display.newRect(0, 0, display.contentWidth, display.contentHeight)
	bgRect.anchorX, bgRect.anchorY = 0,0
	bgRect:setFillColor(20/255, 70/255, 10/255, 130/255)
	
	--display.newText( string, left, top, font, size )
	dollaztext = display.newText( "DOLLAZ : " .. mainInventory.dollaz, display.contentWidth * 0.1, display.contentHeight * 0.05, native.systemFont, 25 )
	weighttext = display.newText("SPACE LEFT : ".. mainInventory.weightAvailable, display.contentWidth*0.55, display.contentHeight * 0.05, native.systemFont, 25)
	--local equiptext = display.newText( "EQUIP MENU",  display.contentWidth * 0.35,  display.contentHeight * 0.1, native.systemFont, 25 )
	--local maintext = display.newText( "MAIN WEAPONS",  display.contentWidth * 0.1,  display.contentHeight * 0.2, native.systemFont, 25 )
	--local subtext = display.newText( "SUB WEAPONS",  display.contentWidth * 0.55,  display.contentHeight * 0.2, native.systemFont, 25 )
	
	dollaztext.anchorX, dollaztext.anchorY = 0, 0
	weighttext.anchorX, weighttext.anchorY = 0, 0
	--equiptext.anchorX, equiptext.anchorY = 0, 0
	--maintext.anchorX, maintext.anchorY = 0, 0
	--subtext.anchorX, subtext.anchorY = 0, 0
    -- create the widget buttons
	local centerOfScreenX = display.contentWidth*0.5

	backButton = createBttn(widget, display, "Back", display.contentWidth * 0.5, 
		display.contentHeight * 0.92, back)
		
	
	
	group:insert( background )
	group:insert( bgRect )
	
	group:insert( dollaztext )
	group:insert( weighttext )
	--group:insert( equiptext )
	--group:insert( maintext )
	--group:insert( subtext )
	
	createEquipMenuMVC(scene, group)

	group:insert( backButton )
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	dollaztext.text = "DOLLAZ : " .. tostring(mainInventory.dollaz)
	weighttext.text = "SPACE LEFT : " .. tostring(mainInventory.weightAvailable)
	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.
	
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	-- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
	
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	
	if backButton then
		backButton:removeSelf()	-- widgets must be manually removed
		backButton = nil
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